addpath(genpath('..\MatlabLib'));

%1)Pour  une  fr�quence  Doppler = 10 ,  g�n�rer  100000  �chantillons  qui  seront 
%  transmis sur un canal de Rayleigh � un rythme de 10 ksymbs/s. Vous utiliserez l�objet 
%  �rayleighchan� de Matlab.
N = 100E3;
FD = 10;
TS = 1/10E3;
FS = 1/TS;
MODULATOR = comm.BPSKModulator; 

SIGNAL = randsrc(N,1,[0 1]);

CHANNEL = rayleighchan(TS, FD);
CHANNEL.StoreHistory = 1;
%CHANNEL.PathDelays = [0 1e-6]; 

TX_SIGNAL = MODULATOR(SIGNAL);
RX_SIGNAL = filter(CHANNEL, TX_SIGNAL);

%constellation('TX',TX_SIGNAL);
%constellation('RX',RX_SIGNAL);

%2) Avec  la  fonction  �hist�,  montrer que  l�amplitude  de  ces  �chantillons  suit
%   une distribution de probabilit� de Rayleigh et que la phase
%   suit une distribution uniforme.

dist_amp('RX',RX_SIGNAL);
dist_phase('RX',RX_SIGNAL);

%3) A  l�aide  d�une  simulation  appropri�e,  montrer que  ce  canal  n�est  pas  
%   s�lectif  en fr�quence.

plot(CHANNEL); % See Freq Response is flat
SPECTRUM_ANALYZER = dsp.SpectrumAnalyzer;
SPECTRUM_ANALYZER(RX_SIGNAL);

%4) Rappeler la d�finition de temps de coh�rence et bande de coh�rence d�un canal.
%   Quelles  sont  les  valeurs  du  temps  de  coh�rence  et  de  la  bande  de  coh�rence
%   de  ce canal ?

%5) Pour  une  fr�quence  Doppler Fd = [50 100 150],  montrer l�influence
%   de Fd sur l�amplitude des �chantillons.

for FD = 50:50:150
    CHANNEL = rayleighchan(TS, FD);
    RX_SIGNAL = filter(CHANNEL, TX_SIGNAL);
    constellation(sprintf('RX_FD_%d',FD),RX_SIGNAL);
    dist_amp(sprintf('RX_FD_%d',FD),RX_SIGNAL);
end


%6) A l�aide d�une simulation Matlab ou Simulink,  r�aliser des  courbes  de  performances 
%   pour la modulation OQPSK et avec une diversit� L= [1 2 4]. Commenter

% What do you mean by performance? BER?
