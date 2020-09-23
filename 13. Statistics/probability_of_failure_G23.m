%% Bayesian Analysis: ECU without calibration
N_analysis=1000000; %size of the generated sample
x_sensor=rand(N_analysis,1).*0.3-0.15; %Generate a random number: x_sensor e [-0.15;0.15]

%Failure Criteria
x_min=-0.04; %if x_sensor<x_min then failure=1

%Gas Type=G23
P_G23_assumption=1;
P_g23=[0:0.01:1]';


%Boolean variable to determine if failure is present
boolean_failure=ones(N_analysis,1); 
boolean_failure(x_sensor>=x_min)=0; 

for i=1:size(P_g23,1)
p_failure(i)=(sum(boolean_failure)./(size(boolean_failure,1))).*P_g23(i);
    
end

%Graphs with input distributions
figure
subplot(2,1,1)
histogram(x_sensor,'Normalization','probability','FaceColor','k')
xlabel('Pressure Sensor Uncertainty - [mbar]')
ylabel('Probability')
hold on
histogram(x_sensor(x_sensor<=x_min),'Normalization','probability','FaceColor','r')
title('Probability distribution: Pressure Sensor')
ylim([0 0.015])
legend('Pressure Sensor Population','Part of pressure sensor population that can exhibit the failure')

subplot(2,1,2)
plot(P_g23.*100,p_failure.*100,'r')
hold on
xline(P_G23_assumption,'b')
xlabel('Probability of Gas Type = G23')
ylabel('Probability of non-ignition -[%]')
title('Probability of non-ignition with G23 vs Probability of Gas Type =  G23')

txt = horzcat('P(GT=G23) =',num2str(P_G23_assumption),' [%]','-> ','P(failure)= ',num2str(round(p_failure(P_g23==P_G23_assumption./100).*100,2)),' [%]');
text(P_G23_assumption,0.2.*100,txt,'Color','blue')

% 
% 
% 
% %Failure probability Output:
% failure_prob=size(boolean_failure(boolean_failure==1),1)/size(boolean_failure,1);
% disp(horzcat('The probability of failure computed is ', num2str(failure_prob.*100), '[%]'))
% 
% C=[failure_prob*100 (1-failure_prob)*100];
% categories=categorical({'Failure Present','No Failure'});
% subplot(3,1,3)
% bar(categories,C,'r')
% ylabel('Probability of failure occurence in appliance level - [-]')
% yticks([0:10:100]);
% title('Probability of failure occurence in appliance level')