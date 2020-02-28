clear,clc
data = xlsread('RDData01.xlsx', 'Canola Oil');
t=data(:,1);
T=data(:,2);
delt=[];
delT=[];
for n=2 : length(data)
    delt(end+1)=(t(n-1)-t(n));
    delT(end+1)=(T(n-1)-T(n));
end
Cr=delT./delt; %cooling rate array

cp=4280; %specific heat capacity
rho=8495; %density of Inconel
d=.015; %diameter of probe
L=.045; %length of probe
Ts=20; %temp of conola oil in quench tank
V=pi/4*d^2*L; %volume of probe
A=2*pi*d/2*L+2*pi*(d/2)^2; %surface area of a cylinder
qm=-rho*V*cp*Cr; %decrease in internal energy of probe

Tm=[];
for i=2:length(T)
    Tm(end+1)=mean([T(i-1),T(i)]);
end
tm=[];
for i=2:length(t)
    tm(end+1)=mean([t(i-1),t(i)]);
end

h=qm./(A.*(Tm-Ts)); %heat transfer coefficient

figure(1)
plot(t,T)
grid on
title('Temperature Vs. Time')
xlabel('time, s')
ylabel('temperature, °C')

figure(2)
plot(tm,h)
grid on
title('Heat Transfer Coefficient Vs. Midstep Time')
xlabel('Midstep Time, s')
ylabel('Heat Transfer Coefficient, h(J/m^2*s*°C)')

figure(3)
plot(Cr,Tm)
grid on
title('Midstep Temperature Vs. Cooling Rate')
xlabel('Cooling Rate')
ylabel('Midstep Temperature, °C')
