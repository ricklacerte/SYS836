% EXERCICE 3 : Canal s�lectif en fr�quence et Applications aux canaux
% COST 207 et GSM/EDGE
% 1) Qu�est-ce qu�un canal s�lectif en fr�quence ? Expliquer


% 2) Applications COST207 : Les mod�les de canal COST207 ont �t� normalis�s pour
% permettre de simuler des syst�mes de communication � l�aide d�un ensemble commun
% de mod�les de canal. Quatre mod�les de propagation sont d�finis : Rural Area (RA),
% Typical Urban Area (TU), Bad Urban Area (BU) et le Hilly Terrain (HT).
% Dans un premier temps, cr�er les spectres Doppler pour le mod�le COST 207. Ensuite
% un canal de Rayleigh sera appliqu�. Enfin, visualiser certaines propri�t�s du canal.
% Le profil en puissance des retards utilis� est le suivant :
% ? = [0 200 600 1600 2400 5000] ? 1?
% ?9
% ? = [?3 0 ? 2 ? 6 ? 8 ? 10]

% a) Pour une fr�quence Doppler ?? = 10 ??, g�n�rer 50000 �chantillons qui
% seront transmis sur un canal de Rayleigh � un rythme de 1 Msymbs/s. Vous
% utiliserez l�objet � rayleighchan � de Matlab.



% b) A l�aide d�une simulation appropri�e, montrer que ce canal est s�lectif en
% fr�quence.



% 3) Applications GSM/EDGE : Plusieurs mod�les de canaux GSM / EDGE sont bas�s
% sur les mod�les de canaux COST 207, mais avec l�hypoth�se que chaque Rayleighfading
% poss�de un spectre Doppler Jakes.

% a) A l�aide de la fonction � stdchan � de Matlab, construire un mod�le
% GSM/EDGE avec les param�tres suivants :
% M = 8; % ordre de modulation
% NSamples = 1e4; Nombre d��chantillons
% Nframes = 6;
% Rsym = 9600; % Rythme symbole
% Rbit = Rsym * log2(M); % Rythme binaire
% Nos = 4; % facteur de sur�chantillonnage
% ts = (1/Rbit) / Nos; % P�riode d��chantillonnage
% v = 120 * 1e3/3600; % Vitesse du mobile (m/s)
% fc = 1800e6; % Fr�quence porteuse
% c = 3e8; % Vitesse de la lumi�re
% fd = v*fc/c; % Maximum Doppler de la composante diffuse

% b) Visualiser les spectres Doppler et scattering. Commenter
