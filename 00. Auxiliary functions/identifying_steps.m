function [patamar] = identifying_steps(v,varargin)
%identifying_steps: Function that analyses an input vector 'v' and considers as a baseline all the zones where athe first derivative is lower than a specified value


derivative_1=0;
if nargin>1
    for i=1:size(varargin,2)
        if strcmp(varargin{i},'1st_derivative')==1
            derivative_1=1;
            criteria=varargin{i+1};
        end
    end
else
    %Default consideration
    derivative_1=1;
    criteria=0.3;
end



if derivative_1==1
    D_1=diff(v);
    patamar=zeros(size(D_1,1),1);
    patamar(abs(D_1)<criteria)=1;
    patamar(size(patamar,1)+1)=patamar(size(patamar,1));
end



end

