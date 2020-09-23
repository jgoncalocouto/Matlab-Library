function [solar_mode_status] = solar_mode_status(T_in,T_out_expected,T_sp)
solar_mode_status=0;

if T_in>=(T_sp-1)
    solar_mode_status=1;
end

if T_sp<50
    T_sp_max=60;
else
    T_sp_max=T_sp+10;
end

if T_out_expected>=T_sp_max
    solar_mode_status=1;
elseif T_out_expected<(T_sp_max-5)
    solar_mode_status=0;
    
end

