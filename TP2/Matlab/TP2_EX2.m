% 1) On s�int�resse maintenant au canal de Rice. Quelle est la diff�rence entre un canal de
% Rayleigh et celui de Rice ?

%% Un canal de Rice est un canal de type Rayleigh avec trajet direct (line of sight - LOS).
%%

% 2) Pour une fr�quence Doppler FD = 10 et K = 2, g�n�rer 100000 �chantillons qui
% seront transmis sur un canal de Rice � un rythme de 10 ksymbs/s. Vous utiliserez
% l�objet � ricianchan � de Matlab.
Fd = 10;
K = 2;
Ts = 10000;
ricechan = comm.RicianChannel('MaximumDopplerShift', Fd, 'KFactor', K, 'SampleRate', Ts, 'Visualization', 'Frequency response');
%ricianchan(Ts, Fd, K);
x = randsrc(100000,1,[0 1]);
dbspkMod = comm.DBPSKModulator;
dpskSig = dbspkMod(x);
RicianChanOut1 = ricechan (dpskSig);

% 3) Sur le m�me graphique, comparer l�amplitude des �chantillons de ce canal � celui de
% Rayleigh. Lequel est plus s�lectif ? Pourquoi ? Que se passe-t-il si K = 0 ?

% 4) A l�aide d�une simulation Matlab ou Simulink, r�aliser des courbes de performances
% pour la modulation OQPSK avec K = [0 2] et une diversit� L= [1 2 4]. Commenter
