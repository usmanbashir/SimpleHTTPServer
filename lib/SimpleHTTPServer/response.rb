module SimpleHTTPServer
    class HttpResponse

        STATUS_CODES = {
            200 => "200 OK",
            204 => "204 No Content",
            400 => "400 Bad Request",
            403 => "403 Forbidden",
            404 => "404 Not Found",
            408 => "408 Request Timeout",
            500 => "500 Internal Server Error",
            501 => "501 Not Implemented"
        }

        attr_accessor :headers

        def initialize(client)
            @client = client
            @headers = {}
        end

        def content=(value)
            @content = value.to_s
        end
        def content()
            @content || ''
        end
        def content?()
            !!@content
        end

        def status=(status)
            @status = STATUS_CODES[status.to_i] || status
        end

        def content_type(mime, charset="utf-8")
            if mime.length > 0
                @headers["Content-Type"] = "#{mime}; charset=#{charset}"
            else
                @headers["Content-Type"]
            end
        end

        def send_response
            send_headers
            send_body
            close_connection
        end

    private
        def send_headers
            raise "Headers already sent." if @sent_headers
            @sent_headers = true

            if @content
                @headers["Content-Length"] = @content.bytesize
            else
                @headers["Content-Length"] = 0
            end

            header_ary = []
            header_ary << "HTTP/1.1 #{@status || '200 OK'}"
            header_ary << "Date: #{Time.now.localtime(3).strftime("%a, %-d %b %Y %H:%M:%S GMT")}"
            header_ary << "Server: SimpleHTTPServer"

            @headers.each do |k, v|
                header_ary << "#{k}: #{v}"
            end

            header_ary << "\r\n"

            send_data header_ary.join("\r\n")
        end

        def send_body
            send_content
        end

        def send_content
            raise "Content already sent." if @sent_content
            @sent_content = true
            send_data content
        end

        def send_data(data)
            @client.puts data
        end

        def close_connection
            @client.close
        end
    end
end
