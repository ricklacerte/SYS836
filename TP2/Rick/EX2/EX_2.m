addpath(genpath('..\MatlabLib'));

%1) On s’intéresse maintenant au canal de Rice. Quelle est la différence entre un canal de
%  Rayleigh et celui de Rice ?

%TODO... Think it's the doppler phenomena or the effect of a moving receptor. 
% without scattering 

%2) Pour une fréquence Doppler ?? = 10 ?? ?? ? = 2, générer 100000 échantillons qui
%   seront transmis sur un canal de Rice à un rythme de 10 ksymbs/s. Vous utiliserez
%   l’objet « ricianchan » de Matlab.

N = 100E3;
FD = 10;
K=2
TS = 1/10E3;
FS = 1/TS;
MODULATOR = comm.BPSKModulator; 

SIGNAL = randsrc(N,1,[0 1]);

TX_SIGNAL = MODULATOR(SIGNAL);

RIC_CHANNEL = ricianchan(TS, FD, K);
RIC_CHANNEL.StoreHistory = 1;
%CHANNEL.PathDelays = [0 1e-6]; 

RAY_CHANNEL = rayleighchan(TS, FD);
RAY_CHANNEL.StoreHistory = 1;
%CHANNEL.PathDelays = [0 1e-6]; 

%3) Sur le même graphique, comparer l’amplitude des échantillons de ce canal à celui de
%   Rayleigh. Lequel est plus sélectif ? Pourquoi ? Que se passe-t-il si ? = 0 ?

RX_SIGNAL = filter(RIC_CHANNEL, TX_SIGNAL);
dist_amp({'Rayleigh','Rician'},horzcat(filter(RAY_CHANNEL, TX_SIGNAL),filter(RIC_CHANNEL, TX_SIGNAL)));

SPECTRUM_ANALYZER = dsp.SpectrumAnalyzer;
SPECTRUM_ANALYZER(RX_SIGNAL);
plot(RIC_CHANNEL);

K=0;
RIC_CHANNEL = ricianchan(TS, FD, K);
dist_amp({'Rayleigh','Rician'},horzcat(filter(RAY_CHANNEL, TX_SIGNAL),filter(RIC_CHANNEL, TX_SIGNAL)));
% K=0, devient comme le channel Rayleigh.

%4) A l’aide d’une simulation Matlab ou Simulink, réaliser des courbes de performances
%   pour la modulation OQPSK avec ? = [0 2] et une diversité L= [1 2 4]. Commenter
FD = 10;
MODULATOR = comm.OQPSKModulator; 
CHANNEL = rayleighchan(TS, FD);
CHANNEL.StoreHistory = 1;
%CHANNEL.PathDelays = [0 1e-6]; 
EBNO=[0:20]
figure()

for K = [0 2]
    ber = zeros(length(EBNO),4);
    for L = 1:4
        ber(:,L) = berfading(EBNO,'oqpsk',L,K);
    end
    figure()
    semilogy(EBNO,ber,'b')
    text(18.5, 0.02, sprintf('L=%d',1))
    text(18.5, 1e-11, sprintf('L=%d',4))
    title(sprintf('OQPSK over fading channel with diversity order 1 to 4, K=%d',K))
    xlabel('E_b/N_0 (dB)')
    ylabel('BER')
    grid on
end
