addpath(genpath('..\MatlabLib'));

%1)Pour  une  fréquence  Doppler = 10 ,  générer  100000  échantillons  qui  seront 
%  transmis sur un canal de Rayleigh à un rythme de 10 ksymbs/s. Vous utiliserez l’objet 
%  «rayleighchan» de Matlab.
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

%2) Avec  la  fonction  «hist»,  montrer que  l’amplitude  de  ces  échantillons  suit
%   une distribution de probabilité de Rayleigh et que la phase
%   suit une distribution uniforme.

dist_amp('RX',RX_SIGNAL);
dist_phase('RX',RX_SIGNAL);

%3) A  l’aide  d’une  simulation  appropriée,  montrer que  ce  canal  n’est  pas  
%   sélectif  en fréquence.

plot(CHANNEL); % See Freq Response is flat
SPECTRUM_ANALYZER = dsp.SpectrumAnalyzer;
SPECTRUM_ANALYZER(RX_SIGNAL);

%4) Rappeler la définition de temps de cohérence et bande de cohérence d’un canal.
%   Quelles  sont  les  valeurs  du  temps  de  cohérence  et  de  la  bande  de  cohérence
%   de  ce canal ?

%5) Pour  une  fréquence  Doppler Fd = [50 100 150],  montrer l’influence
%   de Fd sur l’amplitude des échantillons.

for FD = 50:50:150
    CHANNEL = rayleighchan(TS, FD);
    RX_SIGNAL = filter(CHANNEL, TX_SIGNAL);
    constellation(sprintf('RX_FD_%d',FD),RX_SIGNAL);
    dist_amp(sprintf('RX_FD_%d',FD),RX_SIGNAL);
end


%6) A l’aide d’une simulation Matlab ou Simulink,  réaliser des  courbes  de  performances 
%   pour la modulation OQPSK et avec une diversité L= [1 2 4]. Commenter

% What do you mean by performance? BER?
