function [V] = create_ramp(step_start,step_end,vector_size,transition_point,transition_duration)
%create_step Creates a vector with a ramp in the transition (with size=vector_size) that goes linearly from step_start to step_end at index=transition_point for a given time period (transition_duration)

V=ones(vector_size,1).*step_start;
V(transition_point:vector_size,1)=step_end;

x1=transition_point
x2=transition_point+transition_duration
y1=step_start
y2=step_end

m=(y1-y2)/(x1-x2)
b=y1-m*x1


for i=x1:x2
V(i)=m*i+b;
end

end
