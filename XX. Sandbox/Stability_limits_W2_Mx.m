%Gas Mix Limits for W2
Pi_2=linspace(6,14,100);
Pi_1=linspace(45.6,55,100);


%Data in Mx

%Gas Type:
X_C4H10=0.4;
X_C3H8=0.6;

FLL_MX=W2_flameliftlimit('G31',Pi_2).*X_C3H8+W2_flameliftlimit('G30',Pi_2).*X_C4H10;
LPRL_MX=W2_LowPitchResonance('G31',Pi_1).*X_C3H8+W2_LowPitchResonance('G30',Pi_1).*X_C4H10;

figure
plot(Pi_2,FLL_MX,'ro')
figure
plot(Pi_1,LPRL_MX,'b*')

%P1
