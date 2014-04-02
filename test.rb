require "./lib/SimpleHTTPServer"

test_server = SimpleHTTPServer::HttpServer.new()
test_server.run
