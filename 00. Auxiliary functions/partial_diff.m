function [d] = partial_diff(v,w)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=v(2:size(v,1));
b=v(1:size(v,1)-1);
c=w(2:size(w,1));
d=w(1:size(w,1)-1);

d=(a-b)./(c-d);

d=[0;d];
end

