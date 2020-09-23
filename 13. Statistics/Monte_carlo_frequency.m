%% Bayesian Analysis: ECU without calibration
N_analysis=1000000; %size of the generated sample
x_sensor=rand(N_analysis,1).*0.3-0.15; %Generate a random number: x_sensor e [-0.15;0.15]

%Cumulative probability distribution measured from calibration rework (Frequency Offset)
cpf_frequency=[-0.160000000000000 0;-0.150000000000000 0.0260416670000000;2.40000000000000 0.0312500000000000;6 0.0468750000000000;6.90000000000000 0.0625000000000000;9 0.0781250000000000;10.0500000000000 0.0885416670000000;10.9500000000000 0.0937500000000000;12 0.114583333000000;13.0500000000000 0.145833333000000;14.1000000000000 0.192708333000000;15.1500000000000 0.203125000000000;16.0500000000000 0.369791667000000;17.1000000000000 0.437500000000000;18.1500000000000 0.562500000000000;19.2000000000000 0.666666667000000;20.2500000000000 0.750000000000000;21.1500000000000 0.817708333000000;22.2000000000000 0.890625000000000;23.2500000000000 0.942708333000000;24.3000000000000 0.979166667000000;26.4000000000000 0.989583333000000;27.4500000000000 0.994791667000000;36.7500000000000 1];
pd_frequency=makedist('PieceWiselinear','x',cpf_frequency(:,1),'Fx',cpf_frequency(:,2)); %Create a costum-made probability distribution from the measured data
x_frequency=random(pd_frequency,N_analysis,1); %Generate random numbers the frequency distribution measured
x_frequency_min=-90.*x_sensor+ 21.667; % Calculate the Min Frequency which causes a failure for each x_sensor randomly generated

%Boolean variable to determine if failure is present
boolean_failure=ones(N_analysis,1); 
boolean_failure(x_frequency>=x_frequency_min)=0; 

%Graphs with input distributions
figure
subplot(3,1,1)
histogram(x_sensor,'Normalization','probability','FaceColor','k')
title('Probability distribution: Pressure Sensor')


subplot(3,1,2)
histogram(x_frequency,'Normalization','probability')
ylabel('Probability density - [-]')
title('Probability distribution: ECU Calibration-Offset Measured')



%Failure probability Output:
failure_prob=size(boolean_failure(boolean_failure==1),1)/size(boolean_failure,1);
disp(horzcat('The probability of failure computed is ', num2str(failure_prob.*100), '[%]'))

C=[failure_prob*100 (1-failure_prob)*100];
categories=categorical({'Failure Present','No Failure'});
subplot(3,1,3)
bar(categories,C,'r')
ylabel('Probability of failure occurence in appliance level - [-]')
yticks([0:10:100]);
title('Probability of failure occurence in appliance level')