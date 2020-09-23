classdef CDaqData < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        bufTime
        bufData 
    end
    
    methods     
        %% ----------------------------------------------------------------
        function obj = CDaqData(bufSize)

            %assert(isa(bufSize,'int64'))                
               
            obj.setup(bufSize);
        end
        
        %% ----------------------------------------------------------------        
        function delete(obj)
%             obj.bufTime.delete;
%             obj.bufData.delete;
        end
        
        function setup(obj, bufSize)
            obj.bufTime=circBuf(bufSize);
            obj.bufData=circBuf(bufSize);
        end
    end
    
end

