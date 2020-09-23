%% Model Plots

figure
ax1=subplot(2,1,1);
title(['Overshoot caused by a Water Flowrate transition of ' num2str(Vdot_water.value(1)) ' to ' num2str(Vdot_water.value(t_size)) '[l/min]'])
hold on
j=0;
ylim([0 100])

for j=1:size(data,2)
plot(data{j}.t,data{j}.T,'-r')
hold on
plot(data{j}.t,data{j}.T_win,'-b')
plot(data{j}.t,ones(length(data{j}.t),1).*85)
x1=xline(data{1}.t(I),'r--',{'Predicted Overshoot',strcat('\Deltat_{required} =',{'  '},string(data{1}.t(I)-t_transition),{' '},'[s]')});
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
xlabel('Elapsed time - [s]')
ylabel('Water Temperature')
legend_1{j}=['Outlet Water Temperature - [ºC]'];
end

legend_1{j+1}=['Inlet Water Temperature - [ºC]'];
legend_1{j+2}=['Maximum allowed T before cut: 85ºC - [ºC]'];
lgd=legend(legend_1);
lgd.Location='southeast';

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