function [afr]=afr(gastype,vol_mass)
gas_list={ 'G20' 1 4
    'G30' 4 10
    'G31' 3 8};
for i=1:length(gas_list)
if strcmp(gastype,cell2mat(gas_list(i,1)))==1
    N_C=cell2mat(gas_list(i,2));
    N_H=cell2mat(gas_list(i,3));
end
end

if strcmp(vol_mass,'vol')==1
afr=((N_C+N_H/4))*(1/0.21);
    
elseif strcmp(vol_mass,'mass')==1
afr=(((N_C+N_H/4))*(1/0.21))*(28.966/(N_C*12.01+N_H*1.008));
end

end
