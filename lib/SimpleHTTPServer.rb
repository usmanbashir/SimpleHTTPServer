require_relative "./SimpleHTTPServer/version"
require_relative "./SimpleHTTPServer/response"
require "socket"

module SimpleHTTPServer
    class HttpServer

        def initialize(ip='0.0.0.0', port=3000, path='')
            @serverSocket = TCPServer.new(ip, port)
            printf(
                "SimpleHTTPServer: listening on %s:%s\n",
                @serverSocket.addr[2],
                @serverSocket.addr[1]
            )
            run
        end

    private
        def run
            loop do
                Thread.start(@serverSocket.accept) do |client|
                    request = client.gets
                    logger([
                        Time.now.localtime.strftime('%Y/%m/%d %H:%M:%S'),
                        client.peeraddr[2],
                        request
                    ].join(" - "))

                    response = HttpResponse.new(client)
                    response.content_type "text/html"
                    response.content = "Hey, live long and prosper! :)\r\n"
                    response.send_response
                end
            end
        end

        def logger(msg)
            puts msg
        end

    end
end
