%1)Pour  une  fréquence  Doppler = 10 ,  générer  100000  échantillons  qui  seront 
%  transmis sur un canal de Rayleigh à un rythme de 10 ksymbs/s. Vous utiliserez l’objet 
%  «rayleighchan» de Matlab.
N = 100E3;
FD = 10;
TS = 1/10E3;

SIGNAL = randsrc(N,1,[0 1]);
CHANNEL = rayleighchan(TS, FD);
MODULATOR = comm.BPSKModulator; 
MOD_SIGNAL = MODULATOR(SIGNAL);
RESULT_SIGNAL = filter(CHANNEL, MOD_SIGNAL);

scatterplot(MOD_SIGNAL)
title('Constellation du Signal Modulé');
xlabel('In-Phase');
ylabel('Quadrature');
savefig('signal_constellation.fig');
saveas(gcf,'signal_constellation.png')

scatterplot(RESULT_SIGNAL)
title('Constellation du Signal Résultant dans un Canal de Rayleigh');
xlabel('In-Phase');
ylabel('Quadrature');
savefig('rayleigh_constellation.fig');
saveas(gcf,'rayleigh_constellation.png')


%2) Avec  la  fonction  «hist»,  montrer que  l’amplitude  de  ces  échantillons  suit
%   une distribution de probabilité de Rayleigh et que la phase
%   suit une distribution uniforme.
HIST_AMP = figure('Name','Distribution de l''amplitude','NumberTitle','off');
histogram(abs(RESULT_SIGNAL), 'Normalization','probability');
title('Distribution de l''amplitude du signal dans un canal de Rayleigh');
xlabel('Amplitude du signal résultant');
ylabel('Probabilité');
savefig('rayleigh_amp_dist.fig');
saveas(HIST_AMP,'rayleigh_amp_dist.png')

HIST_PHASE = figure('Name','Distribution de la phase','NumberTitle','off');
histogram(angle(RESULT_SIGNAL), 'Normalization','probability');
title('Distribution de la phase du signal dans un canal de Rayleigh');
xlabel('Phase du signal résultant');
ylabel('Probabilité');
savefig('rayleigh_phase_dist.fig');
saveas(HIST_AMP,'rayleigh_phase_dist.png')


%3) A  l’aide  d’une  simulation  appropriée,  montrer que  ce  canal  n’est  pas  
%   sélectif  en fréquence.

% REP: Le Canal est sélectif en fréquence si le temps d'un symbole (TS) est plus
% grand que l'étalement du délais (Delay spread).


%4) Rappeler la définition de temps de cohérence et bande de cohérence d’un canal.
%   Quelles  sont  les  valeurs  du  temps  de  cohérence  et  de  la  bande  de  cohérence
%   de  ce canal ?

%5) Pour  une  fréquence  Doppler Fd = [50 100 150],  montrer l’influence
%   de Fd sur l’amplitude des échantillons.

%6) A l’aide d’une simulation Matlab ou Simulink,  réaliser des  courbes  de  performances 
%   pour la modulation OQPSK et avec une diversité L= [1 2 4]. Commenter

