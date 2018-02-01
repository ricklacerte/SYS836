%1)Pour  une  fr�quence  Doppler = 10 ,  g�n�rer  100000  �chantillons  qui  seront 
%  transmis sur un canal de Rayleigh � un rythme de 10 ksymbs/s. Vous utiliserez l�objet 
%  �rayleighchan� de Matlab.
N = 100E3;
FD = 10;
TS = 1/10E3;

SIGNAL = randsrc(N,1,[0 1]);
CHANNEL = rayleighchan(TS, FD);
MODULATOR = comm.BPSKModulator; 
MOD_SIGNAL = MODULATOR(SIGNAL);
RESULT_SIGNAL = filter(CHANNEL, MOD_SIGNAL);

scatterplot(MOD_SIGNAL)
title('Constellation du Signal Modul�');
xlabel('In-Phase');
ylabel('Quadrature');
savefig('signal_constellation.fig');
saveas(gcf,'signal_constellation.png')

scatterplot(RESULT_SIGNAL)
title('Constellation du Signal R�sultant dans un Canal de Rayleigh');
xlabel('In-Phase');
ylabel('Quadrature');
savefig('rayleigh_constellation.fig');
saveas(gcf,'rayleigh_constellation.png')


%2) Avec  la  fonction  �hist�,  montrer que  l�amplitude  de  ces  �chantillons  suit
%   une distribution de probabilit� de Rayleigh et que la phase
%   suit une distribution uniforme.
HIST_AMP = figure('Name','Distribution de l''amplitude','NumberTitle','off');
histogram(abs(RESULT_SIGNAL), 'Normalization','probability');
title('Distribution de l''amplitude du signal dans un canal de Rayleigh');
xlabel('Amplitude du signal r�sultant');
ylabel('Probabilit�');
savefig('rayleigh_amp_dist.fig');
saveas(HIST_AMP,'rayleigh_amp_dist.png')

HIST_PHASE = figure('Name','Distribution de la phase','NumberTitle','off');
histogram(angle(RESULT_SIGNAL), 'Normalization','probability');
title('Distribution de la phase du signal dans un canal de Rayleigh');
xlabel('Phase du signal r�sultant');
ylabel('Probabilit�');
savefig('rayleigh_phase_dist.fig');
saveas(HIST_AMP,'rayleigh_phase_dist.png')


%3) A  l�aide  d�une  simulation  appropri�e,  montrer que  ce  canal  n�est  pas  
%   s�lectif  en fr�quence.

% REP: Le Canal est s�lectif en fr�quence si le temps d'un symbole (TS) est plus
% grand que l'�talement du d�lais (Delay spread).


%4) Rappeler la d�finition de temps de coh�rence et bande de coh�rence d�un canal.
%   Quelles  sont  les  valeurs  du  temps  de  coh�rence  et  de  la  bande  de  coh�rence
%   de  ce canal ?

%5) Pour  une  fr�quence  Doppler Fd = [50 100 150],  montrer l�influence
%   de Fd sur l�amplitude des �chantillons.

%6) A l�aide d�une simulation Matlab ou Simulink,  r�aliser des  courbes  de  performances 
%   pour la modulation OQPSK et avec une diversit� L= [1 2 4]. Commenter

