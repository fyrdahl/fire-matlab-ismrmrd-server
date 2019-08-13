classdef logging < handle
    
    % Created by Alexander Fyrdahl <alexander.fyrdahl@gmail.com>
    % Inspired by log4m by Luke Winslow <lawinslow@gmail.com>
    
    properties(Access = protected)
        filename;
    end
    
    methods (Static)
        function obj = createLog(filename)
            if nargin < 1
                filename = 'fire.log';
            end
            
            persistent thisObj;
            if isempty(thisObj) || ~isvalid(thisObj)
                thisObj = logging(filename);
            end
            obj = thisObj;
        end
    end
    
    methods
        
        function trace(self,varargin)
            writeLog(self,0,sprintf(varargin{:}));
        end
        
        function debug(self,varargin)
            writeLog(self,1,sprintf(varargin{:}));
        end
        
        function info(self,varargin)
            writeLog(self,2,sprintf(varargin{:}));
        end
        
        function warn(self,varargin)
            writeLog(self,3,sprintf(varargin{:}));
        end
        
        function error(self,varargin)
            writeLog(self,4,sprintf(varargin{:}));
        end
        
    end
    
    methods (Access = private)
        
        function self = logging(filename)
            self.filename = filename;
        end
        
        function writeLog(self,level,message)
                        
            switch level
                case 1
                    levelStr = 'DEBUG';
                case 2
                    levelStr = 'INFO';
                case 3
                    levelStr = 'WARN';
                case 4
                    levelStr = 'ERROR';
                otherwise
                    levelStr = 'TRACE';
            end
            
            % Write to log file,
            fid = fopen(self.filename,'a');
            fprintf(fid,'%s %s - %s\n' ...
                , datestr(now,'yyyy-mm-dd HH:MM:SS,FFF') ...
                , levelStr ...
                , message);
            fclose(fid);
            
            % but output to terminal as well
            fprintf('%s %s - %s\n' ...
                , datestr(now,'yyyy-mm-dd HH:MM:SS,FFF') ...
                , levelStr ...
                , message);

        end
    end
end
