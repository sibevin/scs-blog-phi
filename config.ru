# Serve our index file by default
use Rack::Static, :root => "app",
                  :urls => ["/css", "/js", "/layout", "/posts"],
                  :index => "index.html"
 
# Setup Rack
run Rack::URLMap.new({
  "/" => Rack::Directory.new( "app" ), # Serve our static content
})
