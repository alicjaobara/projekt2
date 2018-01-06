%po plot i wszystkim do tego print('Re1','-dpng');
%dane z MatLaba do Simulinka
czas=200;

K=1.4;
T1=1/14;
T2=100;
T3=10;
T4=1;
T0=25;

%do PID
Kp=1;
Ti=1;
Td=20;

sim('symulacja',czas);
