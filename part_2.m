%Tomasz Lejkowski Wireless Techniques and Systems
%04.05.2021
%part 2
clc ; close all; clear; 
ncarriers = 207; %B mode of DRM
FFTsize=1019;
fs=48e3;
carrier1=159; 
hpn=comm.PNSequence('Polynomial',[7 6 0],'SamplesPerFrame',207,'InitialConditions',[1 1 1 1 1 1 0 ]);
%data=[1 0 1 1 1 1 0 1 0 1 1 0 0 1 0 0 0 1 1 1 1 1 0 1 0 1 1 0 0 1 0 0 0 1 1 1 1 1 0 1 0 1 1 0 0 1 0 0 0 1 0 1];
data=step(hpn);
pskData=pskmod(data,2,pi);
pskData'
scatterplot(pskData);
pause;
datavector = zeros(FFTsize,1);
datavector(carrier1:carrier1+ncarriers-1)=pskData;
datavector,
TX=ifft(datavector);
RealTX=real(TX);
figure(1);
    plot(RealTX);
figure(2);
    pwelch(RealTX,[],[],[],fs);
SNR=15;
RX=awgn(RealTX,SNR,'measured',[],'dB');
afterFFT=fft(RX);
receivedSymbols=afterFFT(carrier1:carrier1+ncarriers-1);
scatterplot(receivedSymbols);
pause;
receivedData=pskdemod(receivedSymbols,2,pi);
figure(3);
subplot(211);stairs(data,'b');axis([1 16 -0.1 1.1]);
subplot(212);stairs(receivedData,'r');axis([1 16 -0.1 1.1]);

B=repmat(receivedData,400,1);
audiowrite('test1_OFDM_radio.wav',B,48e3);
