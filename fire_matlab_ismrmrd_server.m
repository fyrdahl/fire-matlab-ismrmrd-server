function fire_matlab_ismrmrd_server(varargin)
    
    % Alexander Fyrdahl, 2019
    addpath('mex');
    try
        if(exist('OCTAVE_VERSION', 'builtin') > 0)
            javaaddpath('/usr/share/java/xercesImpl.jar');
            javaaddpath('/usr/share/java/xml-apis.jar');
        end
    end

    if nargin < 1
        port = 9002;
    else
        port = varargin{1};
    end

    ismrmrd_server = server(port);
    serve(ismrmrd_server);
end
