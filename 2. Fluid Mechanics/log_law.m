
function F=log_law(u_str,v,k,B,vu,R)
F=v-u_str*((1/k)*log((R*u_str)/(vu))+B);
end