clear;clc
V11=[1.9:0.1:11]';
V22=ones(length(V11),1);

for w=1:length(V11)
    selection=V11(w)
    steps
    V22(w)=abc;
end