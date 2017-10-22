require 'rack/jekyll'
require 'yaml'
require 'rack/ssl-enforcer'
use Rack::SslEnforcer
run Rack::Jekyll.new