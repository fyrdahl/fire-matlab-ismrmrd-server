classdef connection < handle
    
    % Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>
    
    properties
        socket
    end

    methods
        function obj = connection(socket)
            obj.socket = socket;
        end

        function out = read(obj,length)
            out = SocketRead(obj.socket,length);
            out = swapbytes(typecast(out,'uint8'));
        end

        function obj = write(obj,bytes)
            SocketWrite(obj.socket,bytes);
        end

        function [out,obj] = next(obj)
            out = [];
            identifier = read_gadget_message_identifier(obj);
            switch identifier
                case constants.GADGET_MESSAGE_CONFIG_FILE
                    out = read_gadget_message_config_file(obj);
                case constants.GADGET_MESSAGE_CONFIG_SCRIPT
                    out = self.read_gadget_message_config_script(obj);
                case constants.GADGET_MESSAGE_PARAMETER_SCRIPT
                    out = read_gadget_message_parameter_script(obj);
                case constants.GADGET_MESSAGE_CLOSE
                    obj = read_gadget_message_close(obj);
                case constants.GADGET_MESSAGE_ISMRMRD_ACQUISITION
                    out = read_gadget_message_ismrmrd_acquisition(obj);
                case constants.GADGET_MESSAGE_ISMRMRD_WAVEFORM
                    out = read_gadget_message_ismrmrd_waveform(obj);
                case constants.GADGET_MESSAGE_ISMRMRD_IMAGE
                    out = read_gadget_message_ismrmrd_image(obj);
                otherwise
                    unknown_message_identifier(identifier);
            end
        end

        function unknown_message_identifier(identifier)
            fprintf('Received unknown message type: %d', double(identifier));
            error('Iterator:StopIteration', 'Stop iteration');
        end

        function identifier = read_gadget_message_identifier(obj)
            identifier_bytes = read(obj,constants.SIZEOF_GADGET_MESSAGE_IDENTIFIER);
            identifier = typecast(identifier_bytes,'uint16');
        end

        function length = read_gadget_message_length(obj)
            length_bytes = read(obj,constants.SIZEOF_GADGET_MESSAGE_LENGTH);
            length = typecast(length_bytes,'uint32');
        end

        function out = read_gadget_message_config_script(obj)
            length = read_gadget_message_length(obj);
            out = read(obj,length);
        end

        function config_file = read_gadget_message_config_file(obj)
            config_file_bytes = read(obj,constants.SIZEOF_GADGET_MESSAGE_CONFIGURATION_FILE);
            config_file = strtok(char(config_file_bytes)',char(0));
        end

        function out = read_gadget_message_parameter_script(obj)
            length = read_gadget_message_length(obj);
            out = strtok(char(read(obj,length))',char(0));
        end

        function obj = read_gadget_message_close(obj)
            % TODO
        end

        function out = read_gadget_message_ismrmrd_acquisition(obj)
            header_bytes = read(obj,constants.SIZEOF_GADGET_ACQUISITION_HEADER);
            header = ismrmrd.AcquisitionHeader(header_bytes);

            dims = [header.number_of_samples, header.active_channels];

            trajectory_bytes = read(obj, header.number_of_samples * header.trajectory_dimensions * 4);
            traj = typecast(trajectory_bytes','single');

            data_bytes = read(obj, header.number_of_samples * header.active_channels * 8);
            data = typecast(data_bytes,'single');

            out = ismrmrd.Acquisition();
            out.head = header;

            if ~isempty(traj)
                out.traj{:} = reshape(traj, dims);
            end
            if ~isempty(data)
                out.data{:} = reshape(data(1:2:end) + 1j*data(2:2:end), dims);
            end
        end

        function out = read_gadget_message_ismrmrd_waveform(obj)
            % TODO
        end

        function out = read_gadget_message_ismrmrd_image(obj)
            % TODO
        end

        function obj = write_gadget_message_close(obj)
            msg = typecast(uint16(constants.GADGET_MESSAGE_CLOSE),'uint8');
            write(obj,msg);
        end

        function obj = send_image(obj,image)
            ID = typecast(uint16(constants.GADGET_MESSAGE_ISMRMRD_IMAGE),'uint8');
            write(obj,ID);
            write(obj,image.head_.toBytes());
            write(obj,typecast(uint64(length(image.attribute_string_)),'uint8'));
            write(obj,char(image.attribute_string_));
            write(obj,uint16(image.data_));
            write_gadget_message_close(obj);
        end
    end
end
