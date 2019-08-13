classdef simplefft < handle
    % Alexander Fyrdahl, 2019
    methods (Static)

        function image = process(conn,config,header)

           fprintf('Reconstructing %s\n',config);

           hdr = ismrmrd.xml.deserialize(header);
           encoding_x = hdr.encoding.encodedSpace.matrixSize.x;
           encoding_y = hdr.encoding.encodedSpace.matrixSize.y;
           recon_x = hdr.encoding.reconSpace.matrixSize.x;
           recon_y = hdr.encoding.reconSpace.matrixSize.y;
           num_coils = hdr.acquisitionSystemInformation.receiverChannels;

           meas = next(conn);
           while ~meas.head.flagIsSet(meas.head.FLAGS.ACQ_LAST_IN_SLICE)
                tmp = next(conn);
                if ~meas.head.flagIsSet(meas.head.FLAGS.ACQ_IS_NOISE_MEASUREMENT)
                    append(meas,tmp.head,tmp.traj{:},tmp.data{:});
                end
           end

           ksp = reshape([meas.data{:}],encoding_x,num_coils,encoding_y);
           ksp = permute(ksp,[1 3 2]);
           ksp = fftshift(ifft(fftshift(ksp,1),[],1),1);

           ind1 = floor((encoding_x - recon_x)/2)+1;
           ind2 = floor((encoding_x - recon_x)/2)+recon_x;
           im = ksp(ind1:ind2,:,:);

           im = fftshift(ifft(fftshift(im,2),[],2),2);
           im = sqrt(sum(abs(im).^2,3));

           im = im.*(32768./max(im(:)));
           im = round(im);
           im = int16(im);

           image = ismrmrd.Image();

           image.head_.matrix_size(1) = uint16(recon_x);
           image.head_.matrix_size(2) = uint16(recon_y);
           image.head_.matrix_size(3) = uint16(1);
           image.head_.channels = uint16(1);
           image.head_.data_type = uint16(2);

           meta = ismrmrd.Meta();
           meta.DataRole = 'Image';
           meta.WindowCenter = 16384;
           meta.WindowWidth = 32768;
           image.attribute_string_ = serialize(meta);

           image.data_ = im;

        end
    end
end
