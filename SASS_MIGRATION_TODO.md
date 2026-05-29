# Sass @import to @use Migration TODO

## Issue
Heroku builds showing deprecation warnings:
```
DEPRECATION WARNING [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.
```

## Files to Update

### 1. `/assets/css/style.scss` (5 imports)
- Line 1: `@import "plain";` → `@use "plain";`
- Line 2: `@import "mobile-improvements";` → `@use "mobile-improvements";`
- Line 4: `@import "search";` → `@use "search";`
- Line 5: `@import "toggle";` → `@use "toggle";`
- Line 6: `@import "dark";` → `@use "dark";`

### 2. `/_sass/plain.scss` (3 imports)
- `@import "ext/fonts";` → `@use "ext/fonts";`
- `@import "ext/normalize";` → `@use "ext/normalize";`
- `@import "syntax";` → `@use "syntax";`

### 3. `/_sass/_syntax.scss` (1 import)
- `@import 'ext/solarized-dark';` → `@use 'ext/solarized-dark';`

### 4. `/_sass/dark.scss` (1 import)
- `@import 'ext/solarized-dark';` → `@use 'ext/solarized-dark';`

## Migration Steps

1. **Backup**: Create git branch for safety
2. **Convert imports**: Replace `@import` with `@use` in each file
3. **Handle namespacing**: If variables/mixins are accessed across files, use `@forward` or namespace them
4. **Test build**: Run `bundle exec jekyll build --verbose` to check for errors
5. **Test locally**: Run `bundle exec jekyll serve` and verify styling
6. **Deploy**: Test on staging/production

## Notes
- `@use` creates namespaces (e.g., `plain.$variable`)
- Use `@forward` to re-export styles from imported files
- Order matters with `@use` - use before other rules
- May need `as *` to avoid namespacing: `@use "plain" as *;`

## Timeline
- Dart Sass 3.0.0 timeline not set, but migration should be done soon
- Estimated time: 30-60 minutes including testing