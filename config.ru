require './app'

use Rack::Static, :urls => ["/javascripts", "/stylesheets", "/images"], :root => "public"

run Sinatra::Application