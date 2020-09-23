function [ output_args ] = plotData( src, event )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    plot(event.TimeStamps, event.Data);
    src
end

