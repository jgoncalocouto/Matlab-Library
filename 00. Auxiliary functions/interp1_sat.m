function [y_interp] = interp1_sat(X,Y,x_interp)
% 1-D interpolation with saturation of limits functionality

if x_interp < min(X)
    y_interp=interp1(X,Y,min(X));
elseif x_interp > max(X)
    y_interp=interp1(X,Y,max(X));
else
    y_interp=interp1(X,Y,x_interp);
end


end

