#!/bin/bash

# Script to add SEO tags to Jekyll blog posts using Claude AI
# Usage: ./add_seo_tags.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if claude command is available
if ! command -v claude &> /dev/null; then
    print_error "Claude CLI is not available. Please install it first."
    exit 1
fi

# Function to check if a post already has SEO description
has_seo_description() {
    local file="$1"
    grep -q "^description:" "$file"
}

# Function to extract content for AI analysis (first 500 words)
extract_content_sample() {
    local file="$1"
    # Skip front matter and extract actual content, limit to ~500 words
    sed -n '
        /^---$/,/^---$/{
            /^---$/d
            b
        }
        p
    ' "$file" | head -30 | tr -d '\r'
}

# Function to generate SEO description using AI
generate_seo_description() {
    local file="$1"
    local title="$2"
    local content_sample="$3"
    
    print_status "Generating SEO description for: $title" >&2
    
    # Create temporary file for prompt to avoid shell quoting issues
    local temp_prompt=$(mktemp)
    cat > "$temp_prompt" << EOF
Based on this blog post title and content, generate a single SEO-optimized meta description (150-160 characters max) that would be good for search engines and social media sharing. The description should be compelling, include relevant keywords, and accurately summarize what readers will learn.

Title: $title

Content sample:
$content_sample

Please respond with ONLY the meta description text, no quotes, no explanations, just the description itself.
EOF

    # Use Claude to generate description - only return the actual description
    claude -p < "$temp_prompt" 2>/dev/null | head -1 | tr -d '\n\r'
    rm -f "$temp_prompt"
}

# Function to add SEO description to a post
add_seo_to_post() {
    local file="$1"
    local description="$2"
    
    # Create a temporary file
    local temp_file=$(mktemp)
    
    # Escape quotes in description
    local escaped_desc=$(printf '%s\n' "$description" | sed 's/"/\\"/g' | tr -d '\n\r')
    
    # Simple approach: use head and tail to split file and insert description
    local line_count=$(grep -n "^---$" "$file" | sed -n '2p' | cut -d: -f1)
    if [[ -n "$line_count" ]]; then
        head -n $((line_count - 1)) "$file" > "$temp_file"
        echo "description: \"$escaped_desc\"" >> "$temp_file"
        tail -n +$line_count "$file" >> "$temp_file"
    else
        cp "$file" "$temp_file"
    fi
    
    # Replace original file
    mv "$temp_file" "$file"
}

# Main processing function
process_posts() {
    local post_dir="$1"
    local processed_count=0
    local skipped_count=0
    local error_count=0
    
    print_status "Processing posts in: $post_dir"
    
    # Find all markdown files
    while IFS= read -r -d '' file; do
        print_status "Checking: $(basename "$file")"
        
        # Skip if already has SEO description
        if has_seo_description "$file"; then
            print_warning "Skipping $(basename "$file") - already has SEO description"
            ((skipped_count++))
            continue
        fi
        
        # Extract title from front matter
        title=$(grep "^title:" "$file" | head -1 | sed 's/^title: *//; s/^"//; s/"$//')
        if [[ -z "$title" ]]; then
            print_error "Could not extract title from $(basename "$file")"
            ((error_count++))
            continue
        fi
        
        # Extract content sample
        content_sample=$(extract_content_sample "$file")
        if [[ -z "$content_sample" ]]; then
            print_error "Could not extract content from $(basename "$file")"
            ((error_count++))
            continue
        fi
        
        # Generate SEO description
        description=$(generate_seo_description "$file" "$title" "$content_sample")
        if [[ -z "$description" ]]; then
            print_error "Could not generate description for $(basename "$file")"
            ((error_count++))
            continue
        fi
        
        # Add SEO description to post
        add_seo_to_post "$file" "$description"
        
        print_success "Added SEO description to $(basename "$file"): $description"
        ((processed_count++))
        
        # Small delay to be nice to the API
        sleep 2
        
    done < <(find "$post_dir" -name "*.md" -type f -print0 | sort -z)
    
    # Print summary
    echo
    print_status "Processing Summary:"
    print_success "Processed: $processed_count posts"
    print_warning "Skipped: $skipped_count posts"
    print_error "Errors: $error_count posts"
}

# Main execution
main() {
    echo "🔍 SEO Tag Generator for Jekyll Blog Posts"
    echo "========================================"
    echo
    
    # Check if we're in the right directory
    if [[ ! -f "_config.yml" ]]; then
        print_error "Not in Jekyll root directory (no _config.yml found)"
        exit 1
    fi
    
    # Process both directories
    if [[ -d "_posts" ]]; then
        process_posts "_posts"
    fi
    
    echo
    
    if [[ -d "to_be_cleaned" ]]; then
        process_posts "to_be_cleaned"
    fi
    
    echo
    print_success "SEO tag generation complete!"
    print_status "Review the changes and commit when ready."
}

# Check for command line arguments
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0 [--help]"
    echo
    echo "This script adds SEO description meta tags to Jekyll blog posts"
    echo "that don't already have them, using AI to generate descriptions."
    echo
    echo "Options:"
    echo "  --help, -h    Show this help message"
    echo
    exit 0
fi

# Run main function
main "$@"