names=[string('D100mm flex'); string('D110mm fix');string('D110mm flex'); string('D120mm flex'); string('D80mm fix'); string('D80mm flex')];


Vdot_adjusted_reference=fit(data{5}.tt.DeltaP_v,data{5}.tt.Vdot_measured,'power1');

figure(1);
DeltaP_v=[0:0.01:3];
for i=1:size(data,2)
figure(1);
ax1=subplot(2,2,1);
scatter(data{i}.tt.DeltaP_v,data{i}.tt.Vdot_measured)
legend(names);
title('Measured Flowrate vs Pressure difference in the venturi')
xlabel('Pressure difference in the venturi - [mbar]')
ylabel('Measured Volumetric Flowrate @T=15ºC, 1 atm')
hold on

data{i}.tt.E_abs_baseline=(data{i}.tt.Vdot_measured-Vdot_adjusted_reference(data{i}.tt.DeltaP_v));
data{i}.tt.E_rel_baseline=(data{i}.tt.E_abs_baseline./(Vdot_adjusted_reference(data{i}.tt.DeltaP_v))).*100;
fit_aux=fit(data{i}.tt.DeltaP_v,data{i}.tt.Vdot_measured,'power1');
fit_storage{i}=fit_aux;

ax2=subplot(2,2,2);
scatter(data{i}.tt.DeltaP_v,data{i}.tt.E_rel_baseline);
legend(names);
title('Relative Error (Measured vs Calculated from \DeltaP) vs Pressure difference in the venturi')
xlabel('Pressure difference in the venturi - [mbar]')
ylabel('Relative Error (Measured vs Calculated from \DeltaP) - [%]')
hold on

ax3=subplot(2,2,3);
plot(DeltaP_v,fit_aux(DeltaP_v));
legend(names);
title('Measured Flowrate (Fitted to a Regression) vs Pressure difference in the venturi')
xlabel('Pressure difference in the venturi - [mbar]')
ylabel('Measured Volumetric Flowrate @T=15ºC, 1 atm')
hold on

fit_storage{2,i}=((fit_aux(DeltaP_v)-Vdot_adjusted_reference(DeltaP_v))./Vdot_adjusted_reference(DeltaP_v)).*100;

ax4=subplot(2,2,4);
plot(DeltaP_v,fit_storage{2,i});
legend(names);
title('Relative Error (Fitted to a Regression) vs Pressure difference in the venturi')
xlabel('Pressure difference in the venturi - [mbar]')
ylabel('Relative Error (Measured vs Calculated from \DeltaP) - [%]')
hold on

end
suptitle('Assessment: Inffluence of duct diameter on venturi''s characteristic function ')
linkaxes([ax1 ax3],'xy')
linkaxes([ax2 ax4],'xy')
