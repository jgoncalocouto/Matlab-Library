%% Model Plots

figure
ax1=subplot(2,1,1);
title(['Overshoot caused by a Water Flowrate transition of ' num2str(Vdot_water.value(1)) ' to ' num2str(Vdot_water.value(t_size)) '[l/min]'])
hold on
j=0;

for j=1:size(data,2)
plot(data{j}.t,data{j}.T)
hold on
plot(data{j}.t,ones(length(data{j}.t),1).*85)
xlabel('Elapsed time - [s]')
ylabel('Outlet Water Temperature')
legend_1{j}=['Outlet Water Temperature - [ºC]'];
end

legend_1{j+1}=['Maximum allowed T before cut: 85ºC - [ºC]'];
legend(legend_1)


ax2=subplot(2,1,2);
plot(data{1}.t,data{1}.Q,'k')
xlabel('Elapsed time - [s]')
ylabel('Power Input - [kW]')
ylim([0 max(data{1}.Q)+2])
hold on
yyaxis right
plot(data{1}.t,data{1}.Vdot_water,'b')
ylabel('Water Flow Rate - [l/min]')
ylim([0 max(data{j}.Vdot_water)+2])
legend('Power Input - [kW]','Water Flow Rate - [l/min]')


linkaxes([ax1 ax2],'x')