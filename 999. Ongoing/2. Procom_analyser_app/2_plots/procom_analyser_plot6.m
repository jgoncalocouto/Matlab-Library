%% Plot7: Error Codes

figure
hold on
grid on
i=0;
leg{1}=string('0');
if mean(Aggregate.Error_A4)>0
    a_a4=area(Aggregate.t_relative,Aggregate.Error_A4);
    a_a4.FaceColor = [0.2 0.5 0.4];
    a_a4.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error A4');
end
if mean(Aggregate.Error_A5)>0
    a_a5=area(Aggregate.t_relative,Aggregate.Error_A5);
    a_a5.FaceColor = [0.2 0.6 0.5];
    a_a5.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error A5');
end
if mean(Aggregate.Error_A6)>0
    a_a6=area(Aggregate.t_relative,Aggregate.Error_A6);
    a_a6.FaceColor = [0.2 0.7 0.6];
    a_a6.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error A6');
end
if mean(Aggregate.Error_A7)>0
    a_a7=area(Aggregate.t_relative,Aggregate.Error_A7);
    a_a7.FaceColor = [0.2 0.8 0.7];
    a_a7.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error A7');
end
if mean(Aggregate.Error_A9)>0
    a_a9=area(Aggregate.t_relative,Aggregate.Error_A9);
    a_a9.FaceColor = [0.2 0.9 0.8];
    a_a9.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error A9');
end
if mean(Aggregate.Error_AC)>0
    a_ac=area(Aggregate.t_relative,Aggregate.Error_AC);
    a_ac.FaceColor = [0.2 1 0.9];
    a_ac.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error AC');
end
if mean(Aggregate.Error_C2)>0
    a_c2=area(Aggregate.t_relative,Aggregate.Error_C2);
    a_c2.FaceColor = [1 0.1 1];
    a_c2.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error C2');
end

if mean(Aggregate.Error_C6)>0
    a_c6=area(Aggregate.t_relative,Aggregate.Error_C6);
    a_c6.FaceColor = [0.4 0.5 0.6];
    a_c6.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error C6');
end

if mean(Aggregate.Error_C7)>0
    a_c7=area(Aggregate.t_relative,Aggregate.Error_C7);
    a_c7.FaceColor = [1 0.2 0.1];
    a_c7.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error C7');
end
if mean(Aggregate.Error_CC)>0
    a_cc=area(Aggregate.t_relative,Aggregate.Error_CC);
    a_cc.FaceColor = [1 0.3 0.2];
    a_cc.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error CC');
end
if mean(Aggregate.Error_CF)>0
    a_cf=area(Aggregate.t_relative,Aggregate.Error_CF);
    a_cf.FaceColor = [0 0.25 0.25];
    a_cf.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error CF');
end
if mean(Aggregate.Error_E7)>0
    a_e7=area(Aggregate.t_relative,Aggregate.Error_E7);
    a_e7.FaceColor = [1 0.4 0.3];
    a_e7.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error E7');
end
if mean(Aggregate.Error_E0)>0
    a_e0=area(Aggregate.t_relative,Aggregate.Error_E0);
    a_e0.FaceColor = [1 0.5 0.4];
    a_e0.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error E0');
end
if mean(Aggregate.Error_E1)>0
    a_e1=area(Aggregate.t_relative,Aggregate.Error_E1);
    a_e1.FaceColor = [0.9 0.6 0.5];
    a_e1.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error E1');
end
if mean(Aggregate.Error_E4)>0
    a_e4=area(Aggregate.t_relative,Aggregate.Error_E4);
    a_e4.FaceColor = [0.8 0.7 0.6];
    a_e4.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error E4');
end
if mean(Aggregate.Error_E8)>0
    a_e8=area(Aggregate.t_relative,Aggregate.Error_E8);
    a_e8.FaceColor = [0.7 0.8 0.7];
    a_e8.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error E8');
end
if mean(Aggregate.Error_E9)>0
    a_e9=area(Aggregate.t_relative,Aggregate.Error_E9);
    a_e9.FaceColor = [0.6 0.9 0.8];
    a_e9.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error E9');
end
if mean(Aggregate.Error_EA)>0
    a_ea=area(Aggregate.t_relative,Aggregate.Error_EA);
    a_ea.FaceColor = [0.5 1 1];
    a_ea.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error EA');
end
if mean(Aggregate.Error_EC)>0
    a_ec=area(Aggregate.t_relative,Aggregate.Error_EC);
    a_ec.FaceColor = [0.4 0.9 0.9];
    a_ec.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error EC');
end
if mean(Aggregate.Error_F7)>0
    a_f7=area(Aggregate.t_relative,Aggregate.Error_F7);
    a_f7.FaceColor = [0.3 0.8 0.8];
    a_f7.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error F7');
end
if mean(Aggregate.Error_FA)>0
    a_fa=area(Aggregate.t_relative,Aggregate.Error_FA);
    a_fa.FaceColor = [0.2 0.7 0.7];
    a_fa.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error FA');
end
if mean(Aggregate.Error_F9)>0
    a_f9=area(Aggregate.t_relative,Aggregate.Error_F9);
    a_f9.FaceColor = [0.1 0.6 0.6];
    a_f9.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error F9');
end

if mean(Aggregate.Error_CE)>0
    a_ce=area(Aggregate.t_relative,Aggregate.Error_CE);
    a_ce.FaceColor = [0 0.5 0.5];
    a_ce.FaceAlpha = 0.8;
    i=i+1;
    leg{i}=string('Error CE');
end
title('Error Codes')
xlabel('Elapsed time - t - [s]')
ylabel('Error Code - [1/0]')
legend(leg{:})
