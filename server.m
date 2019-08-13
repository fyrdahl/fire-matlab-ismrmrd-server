classdef server < handle
    % Alexander Fyrdahl, 2019
    properties
        port = [];
        server_socket = [];
        output_socket = [];
    end

    methods
        function obj = server(port)
            fprintf('Initializing server on port %d\n', port);
            obj.port = port;
        end

        function serve(obj)
            fprintf('Serving...\n');
            while true
                try
                    obj.server_socket = ServerSocket(obj.port);
                    fprintf('Waiting for client to connect to this host on port : %d\n', obj.port);
                    [obj.output_socket,remote_socket_address] = SocketAccept(obj.server_socket);
                    fprintf('Accepting connection from: %s\n', remote_socket_address);
                    handle(obj);
                    SocketClose(obj.server_socket);
                    SocketClose(obj.output_socket);
                catch
                    if ~isempty(obj.output_socket)
                        SocketClose(obj.output_socket);
                    end
                    if ~isempty(obj.server_socket)
                        SocketClose(obj.server_socket);
                    end
                    pause(1);
                end
            end
        end

        function handle(obj)
            try
                conn = connection(obj.output_socket);
                config = next(conn);
                parameters = next(conn);
                image = simplefft.process(conn,config,parameters);
                fprintf('Image done, sending!\n');
                send_image(conn,image);
                write_gadget_message_close(conn);
                fprintf('Sending done!\n');
            catch ME
                if strcmp(ME.identifier,'Iterator:StopIteration')
                    SocketClose(obj.output_socket);
                else
                    rethrow(ME);
                end
            end
        end

        function delete(obj)
            if ~isempty(obj.server_socket)
                SocketClose(obj.server_socket);
            end
        end
    end
end
