function k=ploss_local_elbow(D,alpha)
%Calculates k coefficient in function of diameter in mm angle in degrees.

k_90=[75	0.3
100	0.21
125	0.16
150	0.14
180	0.12
200	0.11
230	0.11
250	0.11];

k_45=[75	0.18
100	0.13
125	0.1
150	0.08
180	0.07
200	0.07
230	0.07
250	0.07];

if alpha==45
    k=interp1(k_45(:,1),k_45(:,2),D);
elseif alpha==90
    k=interp1(k_90(:,1),k_90(:,2),D);
end

end