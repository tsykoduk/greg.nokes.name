require 'rack/jekyll'
require 'yaml'
require 'rack/ssl-enforcer'
require 'barnes'

# Other Application Code
use Rack::SslEnforcer
run Rack::Jekyll.new
Barnes.start