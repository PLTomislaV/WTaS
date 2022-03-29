%Tomasz Lejkowski
%Transfer function and impulse response of the radio chanel.
%01.06.2021 

clc; clear; close all;

%ex 1
A=0.9/1; %90% aplitude of reflected signal
A_half=0.5/1; %50% amp of reflected signal

v=3e8; %speed of EM wave

s2=8; % indirect (reflected) path distance
t2=s2/v; % time of reflected indirect path

s1=4; % direct path distance
t1=s1/v; % direct path time 

tau=t2-t1;
f=linspace(2.4*10^9,2.5*10^9,4000); % frequency axis 

H=1+A*exp(-j*2*pi*f*tau);%phase change =0 90% amplitude
H_half=1+A_half*exp(-j*2*pi*f*tau); %second equation with half amplitude 

P=20*log10(H); %convert to power 
P_half=20*log10(H_half);%convert to power 

figure(1);hold on; %draw
title('Ex1');
plot(f,P);
plot(f,P_half);
legend('90% Power Reflected','50% Power Reflected');
ylabel('Power [dB]');
xlabel('Frequency [Hz]');

%ex2
A=0.8/1; %new amplitude

s2=9; %diferent reflected path
t2=s2/v; %reflected timing

s1=3; %direct path
t1=s1/v; %direct timing

tau=t2-t1;
H_e2=1+A*exp(-j*2*pi*f*tau); %phase change =0 shared variables -> v , f
P_e2=20*log10(H_e2);

figure(2); hold on;
title('Ex2');
plot(f,P);
plot(f,P_e2);
legend('90% Power Reflected (scenario 1)','80% Power Reflected (1 meter closer to router)');
ylabel('Power [dB]');
xlabel('Frequency [Hz]');

%ex3
A_r = 0.5/1; %back wall amplitude
A_s = 0.6/1; %side wall amplitude    --------->   the same for left and right wall
A_d = 1; %direct amplitude

s_r = 8; %back wall reflection
s_s = 2*2*sqrt(2); % length of path reflected from the wall
s_d = 4; %direct path

t_r = s_r/v; %back wall timing
t_s = s_s/v; %side wall
t_d = s_d/v; %direct timing

tau_r = t_r-t_d;
tau_s = t_s-t_d;

H_e3 = 1+A_r*exp(-j*2*pi*f*tau_r)+2*A_s*exp(-j*2*pi*f*tau_s);
P_e3 = 20*log10(H_e3); %convert to power

figure(3); hold on;
title('Ex3 back wall A=0.5, left right wall at A=0.6');
plot(f,P_e3);
ylabel('Power [dB]');
xlabel('Frequency [Hz]');

%ex 4
A_s = 0.6/1; %side wall power    --------->   the same for left and right wall
A_d = 1; %direct

s_s = 2*2*sqrt(2); %side wall path
s_d = 4; %direct path

t_s = s_s/v; % time the same for left and right wall
t_d = s_d/v; % time for direct path

tau_s = t_s-t_d;

H = 1+2*A_s*exp(-j*2*pi*f*tau_s)*exp(j*pi); %180 deg phase change
H2 = 1+2*A_s*exp(-j*2*pi*f*tau_s)*exp(j*0); % 0 phase change
P = 20*log10(H);
P2 = 20*log10(H2);

figure(4); hold on;
title('Ex4 no back wall, left right wall at A=0.6 theta=180deg');
plot(f,P);
plot(f,P2);
legend('180 deg phase change','0 phase change');
ylabel('Power [dB]');
xlabel('Frequency [Hz]');

%ex 5
A_s = 0.6/1; %side wall amplitude
A_d = 1;

s_s = 2*2*sqrt(2); %side wall path
s_d = 4; %direct path
t_s=s_s/v; %the same for left and right wall
t_d=s_d/v;

tau_s=t_s-t_d;

f=linspace(1.4*10^9,3.4*10^9,800);
df=2500000;
dt= 1/df;
t=linspace(0,dt,800); %axis for time

H=1+A_s*exp(-j*2*pi*f*tau_s)*exp(j*pi)+A_s*exp(-j*2*pi*f*tau_s)*exp(j*pi)+A_r*exp(-j*2*pi*f*tau_r);
Inv_f=abs(ifft(H));
%P = 20*log10(Inv_f);
figure(5); hold on;
title('Ex5 impulse response');
plot(t,Inv_f);
ylabel('Power [dB]');
xlabel('Frequency [Hz]');
