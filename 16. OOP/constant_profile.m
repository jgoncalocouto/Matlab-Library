classdef constant_profile
    % How to garantee that the transition points are given in ascending order?
    properties
        
        baselines=[];
        
        transition_points=[];
        
        transition_method='null'
        
        vector_length
        
        value=[];
        
        transition_duration=[];
        
        consistency=1;
        
    end
    
    methods
        
        function obj=constant_profile(baselines,vector_length)
            obj.baselines=baselines;
            obj.vector_length=vector_length;
            obj=update_value(obj);
   
        end
        
        
        function obj=update_value(obj)
            
            
            
            if strcmp(obj.transition_method,'null')==1
                obj.value=ones(obj.vector_length,1).*obj.baselines(1);
            end
            
            obj=check_consistency(obj);
            
            if obj.consistency==0
                error('Value not updated. Object Inconsistent')
                obj.value=[];
            end
            
        end
        
        function obj=check_consistency(obj)
            obj.consistency=1;
            if obj.vector_length~=size(obj.value,1) && size(obj.value,1)>0
                obj.consistency=0;
                error('Vector_length property is different from the size of the value property. Object Inconsistent.')
            end
            
        end
        
    end
end
