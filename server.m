classdef server < handle
    
    % Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>
    
    properties
        port = [];
        server_socket = [];
        output_socket = [];
        log = [];
    end

    methods
        function obj = server(port,log)
            log.info('Initializing server on port %d', port);
            obj.port = port;
            obj.log = log;
        end

        function serve(obj)
            obj.log.info('Serving...');
            while true
                try
                    obj.server_socket = ServerSocket(obj.port);
                    obj.log.info('Waiting for client to connect to this host on port : %d', obj.port);
                    [obj.output_socket,remote_socket_address] = SocketAccept(obj.server_socket);
                    obj.log.info('Accepting connection from: %s', remote_socket_address);
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
                image = simplefft.process(conn,config,parameters,obj.log);
                obj.log.info('Image done, sending!');
                send_image(conn,image);
                write_gadget_message_close(conn);
                obj.log.info('Sending done!\n');
            catch ME
                if strcmp(ME.identifier,'Iterator:StopIteration')
                    SocketClose(obj.output_socket);
                else
                    obj.log.error(ME);
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
