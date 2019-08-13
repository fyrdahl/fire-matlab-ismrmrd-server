function fire_matlab_ismrmrd_server(varargin)
    
    % Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>
    
    addpath('mex');
    
    if(isOctave)
        javaaddpath('/usr/share/java/xercesImpl.jar');
        javaaddpath('/usr/share/java/xml-apis.jar');
    end

    if nargin < 1
        port = 9002; 
    else
        port = varargin{1};
    end
    
    if nargin < 2
        logfile = 'fire.log'; 
    else
        logfile = varargin{2};
    end

    log = logging.createLog(logfile);
    ismrmrd_server = server(port,log);
    serve(ismrmrd_server);

end
