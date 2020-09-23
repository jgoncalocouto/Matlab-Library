classdef circBuf < handle
    %circVBuf class defines a circular double buffered vector buffer

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% properties
    %% --------------------------------------------------------------------     
    properties (SetAccess = private, GetAccess = public)
        raw                    % buffer (initialized in constructor)
      
        bufSz@int64 = int64(0) % max number of vectors to store (only change in constructor)
        
        fst@int64   = int64(nan) % first index == position of oldest/first value in circular buffer
        new@int64   = int64(nan) %   new index == position of first new value added in last append()
        lst@int64   = int64(nan) %  last index == position of newest/last value in circular buffer
        
        newCnt@int64= int64(0)   % number of new values added lately (last append call).
        
        AppendType = 0
        append % function pointer to append0,1,2 or 3        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% constructor/destructor
    methods     
        %% ----------------------------------------------------------------
        function obj = circBuf(bufSize, appendType)
            if nargin == 1 % Allow nargin == 1 syntax
                appendType = 0;
            end
            %assert(isa(bufSize,'int64'))                
                
            obj.setup(bufSize, appendType);
        end
        
        %% ----------------------------------------------------------------        
        function delete(obj)
            obj.raw = []; % FIXME: probably not required ?
        end
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% public 
    methods (Access=public)
        %% ----------------------------------------------------------------
        function setup(obj,bufSize,appendType)
            %assert(isa(bufSize,'int64'))                
            
            % buffer initialized once here
            obj.bufSz = int64(bufSize); % fixed values         
            
            obj.AppendType = appendType;
            obj.append = @obj.append0;
            
            if(appendType == 0) % double buffered
              obj.raw  = nan(bufSize, 1, 'double');
              obj.append = @obj.append0;    
            else
              error('append type unkown')
            end
            
            obj.clear();
        end
        
        
        %% ----------------------------------------------------------------        
        function clear(obj)
            
            if(obj.AppendType == 0) % moving first/last index, double buffered
                obj.fst = int64(1);
                obj.lst = int64(1);
            else
                error('AppendType not supported.');
            end
            
            obj.new = obj.lst;     

            obj.newCnt = int64(0);
        end        
       
         %% ----------------------------------------------------------------        
        function vRet=getLast(obj, vSize)
            
            vSz = int64(vSize);
            
            if(vSz > obj.newCnt)
                vSz = obj.newCnt;
            end
            
            gfst= mod(obj.bufSz + obj.lst - vSz, obj.bufSz) + 1;
            
            if(obj.lst < gfst)
                vRet = [ obj.raw(gfst:obj.bufSz);  obj.raw(1:obj.lst)];
            else
                vRet = obj.raw(gfst: obj.lst);
            end
            
        end  
        
        %% ----------------------------------------------------------------     
        function append0(obj, vec)
            %assert(isa(vec,'double')) % disabled because it consumes time   
            
            % preload values == increase performance !?
            f = obj.fst;
            l = obj.lst; 
            n = obj.new;
            
            % preload values == increase performance !?
            vSz  = size(vec,1);
            bSz  = obj.bufSz;
            
            % calc number of vectors to add to buffer and start position in vec            
            %cpSz  = min(vSz, bSz);          % do not copy more vectors than buffer size
            
            % start position in input vector array (we might have to skip values if vSz>bSz)
          
            
            if( (bSz - n + 1) >= vSz ) %vector fits buffer without recycle
                obj.raw(n:(n+vSz-1)) = vec(:);
            else
                obj.raw(n:bSz) = vec(1:bSz-n+1);
                obj.raw(1:vSz-(bSz-n+1)) = vec(bSz-n+2:vSz);
            end
            
            obj.newCnt = obj.newCnt + vSz;
           
            if ( obj.newCnt > bSz ) %overwrite
                obj.newCnt = bSz;
            end
            
            obj.lst = mod((n+vSz-1)-1       ,bSz)+1;
            obj.new = mod((n+vSz)  -1       ,bSz)+1;
            obj.fst = mod(bSz + obj.lst - obj.newCnt +1, bSz);
            
        end
                    
        
    end    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% static
    methods(Static)
        
        %% ---------------------------------------------------------------- 
        function success = test(appendType)
            % TEST Function to test class.
            success = false;
            
            if (nargin < 1) || isempty(appendType)
               appendType = 0;
            end
            
            % setup                        
            bufferSz   = 1000;
            vectorLen  = 7;
            stepSz     = 10;
            steps      = 100;
            
            % create/setup test object
            testObj = circVBuf(int64(bufferSz),int64(vectorLen),appendType);
                        
            % fill circular buffer with steps*stepSz vectors
            vecs = zeros(stepSz,vectorLen,'double');
            %tic
            for i=0:steps-1 % no. steps
                for j=1:stepSz
                    vecs(j,:) = (i*stepSz)+j;
                end
                testObj.append(vecs);
            end
            %toc
            
            % check last bufSz vectors 
            cnt = steps*stepSz;
            for i=testObj.lst:-1:testObj.fst
               vec = testObj.raw(i,:);
               assert( mean(vec(:)) == cnt, 'TEST FAILED: mean(..) ~= cnt');
               cnt = cnt -1;
            end
            
            success = true;
        end
        
    end
    
end

% % create a circular vector buffer
%     bufferSz = 1000;
%     vectorLen= 7;
%     cvbuf = circVBuf(int64(bufferSz),int64(vectorLen));
% 
% % fill buffer with 99 vectors
%     vecs = zeros(99,vectorLen,'double');
%     cvbuf.append(vecs);
% 
% % loop over lastly appended vectors of the circVBuf:
%     new = cvbuf.new;
%     lst = cvbuf.lst;
%     for ix=new:lst
%        vec(:) = cvbuf.raw(:,ix);
%     end
% 
% % or direct array operation on lastly appended vectors in the buffer (no copy => fast)
%     new = cvbuf.new;
%     lst = cvbuf.lst;
%     mean = mean(cvbuf.raw(3:7,new:lst));