classdef variable_profile
    % How to garantee that the transition points are given in ascending order?
    properties
        
        baselines=[]; % set of baselines which makes up the variable_profile
        
        transition_points=[]; % indexes where the transitions starts to occurr
        
        transition_times=[]; % time value correspondent to the indexes where the transitions start to occurr
        
        transition_method='abrupt'
        
        vector_length=0;
        
        value=[];
        
        time=[];
        
        transition_duration_in_indexes=[0]; % number of indexes that each transition take to be performed
        
        transition_duration=[0]; % time interval that each transition takes to be performed
        
        consistency=1;
        
    end
    
    methods
        
        function obj=variable_profile(baselines,time,transition_method,transition_times,transition_duration)
            obj.transition_method=transition_method;
            obj.time=time;
            obj.vector_length=length(time);
            obj.baselines=baselines;
            obj.transition_times=transition_times;
            obj.transition_duration=transition_duration;
            obj=calc_transition_points(obj);
            obj=calc_transition_duration_indexes(obj);
            obj=calc_transition_times(obj,obj.time);
            obj=update_value(obj);
            
            
        end
        
        
        
        function obj=update_value(obj)
            
            if strcmp(obj.transition_method,'abrupt')==1
                obj.value=ones(obj.vector_length,1).*obj.baselines(1);
                if (size(obj.transition_points,2)-1)==0
                    obj.value(obj.transition_points(size(obj.transition_points,2)):obj.vector_length)=obj.baselines(size(obj.baselines,2));
                else
                    i=0;
                    for i=1:(size(obj.transition_points,2)-1)
                        obj.value(obj.transition_points(i):obj.transition_points(i+1))=obj.baselines(i+1);
                    end
                    obj.value(obj.transition_points(size(obj.transition_points,2)):obj.vector_length)=obj.baselines(size(obj.baselines,2));
                end
            elseif strcmp(obj.transition_method,'linear')==1
                if size(obj.transition_duration_in_indexes,2)==size(obj.transition_points,2)
                    %Insert update value for linear method were.
                    obj.value=ones(obj.vector_length,1).*obj.baselines(1);
                    m=zeros(size(obj.transition_points,2),1);
                    x1=m;x2=m;y1=m;y2=m;b=m;
                    if (size(obj.transition_points,2)-1)==0
                        x1(1)=obj.transition_points(1);
                        x2(1)=obj.transition_points(1)+obj.transition_duration_in_indexes(1);
                        y1(1)=obj.baselines(1);
                        y2(1)=obj.baselines(1+1);
                        m(1)=(y1(1)-y2(1))/(x1(1)-x2(1));
                        b(1)=y1(1)-m(1)*(x1(1));
                        obj.value(x1(1):obj.vector_length)=obj.baselines(2);
                        i=0;
                        for i=x1(1):x2(1)
                            obj.value(i)=m(1).*i+b(1);
                        end
                    else
                        obj.value=ones(obj.vector_length,1).*obj.baselines(1);
                        m=zeros(size(obj.transition_points,2),1);
                        x1=m;x2=m;y1=m;y2=m;b=m;
                        for j=1:size(obj.transition_points,2)
                            x1(j)=obj.transition_points(j);
                            x2(j)=obj.transition_points(j)+obj.transition_duration_in_indexes(j);
                            y1(j)=obj.baselines(j);
                            y2(j)=obj.baselines(j+1);
                            m(j)=(y1(j)-y2(j))/(x1(j)-x2(j));
                            b(j)=y1(j)-m(j)*(x1(j));
                            obj.value(x1(j):obj.vector_length)=obj.baselines(j+1);
                            i=0;
                            for i=x1(j):x2(j)
                                obj.value(i)=m(j).*i+b(j);
                            end
                        end
                    end
                    
                    
                    %---end---
                else
                    disp('Invalid size for transition_duration_in_indexes property, it''s value was assigned to a vector of ones of the apropriate size. Please consider revision.')
                    obj.transition_duration_in_indexes=ones(1,size(obj.transition_points,2));
                end
                
            end
            
            %             obj=check_consistency(obj);
            
            %             if obj.consistency==0
            %                 error('Value not updated. Object Inconsistent')
            %                 obj.value=[];
            %             end
            
        end
        
        function obj=check_consistency(obj)
            obj.consistency=1;
            if obj.vector_length~=size(obj.value,1)
                obj.consistency=0;
                error('Vector_length property is different from the size of the value property. Object Inconsistent.')
            elseif max(obj.transition_points)>obj.vector_length
                obj.consistency=0;
                error('At least one of the transition points is higher than the vector length. Object Inconsistent.')
            elseif size(obj.baselines,2)~=(size(obj.transition_points,2)+1)
                obj.consistency=0;
                error('Baselines vector must be one element higher than transition_points vector. Object Inconsistent.')
            elseif size(obj.transition_duration_in_indexes,2)~=size(obj.transition_points,2)
                obj.consistency=0;
                error('transition_duration_in_indexes size is different from transition_points size. Object Inconsistent')
            elseif issortedrows(obj.transition_points',1,{'ascend'})==0
                obj.consistency=0;
                error('Transition points vector must be defined in ascending order. Object Inconsistent')
            end
            
        end
        
        function obj=calc_transition_times(obj,time_vector)
            obj.time=time_vector;
            i=0;
            obj.transition_times=obj.time(obj.transition_points);
            obj.transition_times=obj.transition_times';
        end
        
        function obj=calc_transition_points(obj)
            for i=1:size(obj.transition_times,2)
                [minDistance, a] = min(abs(obj.time-obj.transition_times(i)));
                obj.transition_points(i)=a;
            end
        end
        
        function obj=calc_transition_duration_indexes(obj)
            if size(obj.transition_duration,2)==1
                b=obj.transition_duration;
                obj.transition_duration=ones(1,size(obj.transition_points,2)).*b;
            end
            for i=1:size(obj.transition_duration,2)
                A=find(obj.time<=obj.transition_duration(i));
                obj.transition_duration_in_indexes(i)=(max(size(A,1),size(A,2)));
                clear A
            end
        end
        
        
        %insert method to assure that when you update any property that can affect the value property, the value is re-calculated.
        
        %             function obj=set.baselines(obj,value)
        %                 obj.baselines=value;
        %                 if obj.consistency==0
        %                     error('Value not updated. Object Inconsistent')
        %                 else
        %                     obj=update_value(obj);
        %                 end
        %
        %             end
        %
        %
        %             function obj=set.transition_points(obj,value)
        %                 obj.transition_points=value;
        %                 obj=check_consistency(obj);
        %                 if obj.consistency==0
        %                     error('Value not updated. Object Inconsistent')
        %                 else
        %                     obj=update_value(obj);
        %                 end
        %
        %             end
        %
        %             function obj=set.vector_length(obj,value)
        %                 obj.vector_length=value;
        %                 obj=check_consistency(obj);
        %                 if obj.consistency==0
        %                     error('Value not updated. Object Inconsistent')
        %                 else
        %                     obj=update_value(obj);
        %                 end
        %
        %             end
        %
        %             function obj=set.transition_duration_in_indexes(obj,value)
        %                 obj.transition_duration_in_indexes=value;
        %                 obj=check_consistency(obj);
        %                 if obj.consistency==0
        %                     error('Value not updated. Object Inconsistent')
        %                 else
        %                     obj=update_value(obj);
        %                 end
        %
        %             end
        
    end
end
