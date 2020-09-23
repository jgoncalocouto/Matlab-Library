function [varargout] = patamar_statistics(logicc,tt_test,varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Check if vectors have the same number of lines
if size(logicc,1)~= size(tt_test,1)
    error('Logic vector and table must have the same number of lines')
end


varnames=tt_test.Properties.VariableNames;

patamar_start=find(logicc,1);

if patamar_start==1
    count_elements=1;
else
    count_elements=0;
end

patamar_end=0;
count=1;
for i=2:(size(logicc,1))
    
    if logicc(i)==1
        
        if patamar_start>patamar_end
            for j=1:size(varnames,2)
                T_avg.(varnames{j})(count,1)=mean(tt_test.(varnames{j})(patamar_start:i));
                T_std.(varnames{j})(count,1)=std(tt_test.(varnames{j})(patamar_start:i));
                T_median.(varnames{j})(count,1)=median(tt_test.(varnames{j})(patamar_start:i));
            end
            count_elements=count_elements+1;
        else
            patamar_start=i;
            for j=1:size(varnames,2)
                T_avg.(varnames{j})(count,1)=mean(tt_test.(varnames{j})(patamar_start:i));
                T_std.(varnames{j})(count,1)=std(tt_test.(varnames{j})(patamar_start:i));
                T_median.(varnames{j})(count,1)=median(tt_test.(varnames{j})(patamar_start:i));
            end
            count_elements=count_elements+1;
            
            
        end
    elseif logicc(i)==0 && logicc(i-1)==1
        patamar_end=i-1;
        details.number_of_elements(count,1)=count_elements;
        details.patamar_end(count,1)=patamar_end;
        details.patamar_start(count,1)=patamar_start;
        count_elements=0;
        count=count+1;
    end
    
    
    
end

if logicc(size(logicc,1))==1
    patamar_end=i;
    details.number_of_elements(count,1)=count_elements;
    details.patamar_end(count,1)=patamar_end;
    details.patamar_start(count,1)=patamar_start;
    count_elements=0;
end


for w=1:size(varnames,2)
T_err.(varnames{w})=2.*T_std.(varnames{w})./(sqrt(details.number_of_elements));
end


if nargin>2
    for i=1:size(varargin,2)
        if strcmp(varargin{i},'median')==1
            varargout{i}=struct2table(T_median);
        elseif strcmp(varargin{i},'average')==1
            varargout{i}=struct2table(T_avg);
        elseif  strcmp(varargin{i},'std')==1
            varargout{i}=struct2table(T_std);
        elseif  strcmp(varargin{i},'patamar_details')==1
            varargout{i}=struct2table(details);
        elseif strcmp(varargin{i},'random_uncertainty')
            varargout{i}=struct2table(T_err);
            
        end
    end
else
    varargout{1}=struct2table(T_avg);
end


end

