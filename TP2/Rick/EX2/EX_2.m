addpath(genpath('..\MatlabLib'));

%1) On s�int�resse maintenant au canal de Rice. Quelle est la diff�rence entre un canal de
%  Rayleigh et celui de Rice ?

%TODO... Think it's the doppler phenomena or the effect of a moving receptor. 

%2) Pour une fr�quence Doppler ?? = 10 ?? ?? ? = 2, g�n�rer 100000 �chantillons qui
%   seront transmis sur un canal de Rice � un rythme de 10 ksymbs/s. Vous utiliserez
%   l�objet � ricianchan � de Matlab.

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

%3) Sur le m�me graphique, comparer l�amplitude des �chantillons de ce canal � celui de
%   Rayleigh. Lequel est plus s�lectif ? Pourquoi ? Que se passe-t-il si ? = 0 ?

RX_SIGNAL = filter(RIC_CHANNEL, TX_SIGNAL);
dist_amp({'Rayleigh','Rician'},horzcat(filter(RAY_CHANNEL, TX_SIGNAL),filter(RIC_CHANNEL, TX_SIGNAL)));

plot(RIC_CHANNEL);

K=0;
RIC_CHANNEL = ricianchan(TS, FD, K);
dist_amp({'Rayleigh','Rician'},horzcat(filter(RAY_CHANNEL, TX_SIGNAL),filter(RIC_CHANNEL, TX_SIGNAL)));
% K=0, devient comme le channel Rayleigh.

%4) A l�aide d�une simulation Matlab ou Simulink, r�aliser des courbes de performances
%   pour la modulation OQPSK avec ? = [0 2] et une diversit� L= [1 2 4]. Commenter
FD = 10;
MODULATOR = comm.OQPSKModulator; 
CHANNEL = rayleighchan(TS, FD);
CHANNEL.StoreHistory = 1;
%CHANNEL.PathDelays = [0 1e-6]; 

for L = [2 4]
    MODULATOR = comm.OQPSKModulator('BitInput', true, 'SamplesPerSymbol', L);
    TX_SIGNAL = MODULATOR(SIGNAL);
    for K = [0 2]
        RIC_CHANNEL = ricianchan(TS, FD, K);
        RX_SIGNAL = filter(RIC_CHANNEL, TX_SIGNAL);

        DEMODULATOR = comm.OQPSKDemodulator(MODULATOR);
        DEMOD_SIGNAL = DEMODULATOR(RX_SIGNAL);

        %delay = (1+MODULATOR.BitInput)*modulator.FilterSpanInSymbols;
        [~, ber] = biterr(SIGNAL, DEMOD_SIGNAL);
        fprintf('Bit error rate for L=%d, K=%d: %f\n', L,K,ber);
    end
end
