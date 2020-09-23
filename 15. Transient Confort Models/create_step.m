function [V] = create_step(step_start,step_end,vector_size,transition_point)
%create_step Creates a step vector (with size=vector_size) that goes abruptly from step_start to step_end at index=transition_point

V=ones(vector_size,1).*step_start;
V(transition_point:vector_size,1)=step_end;

end

