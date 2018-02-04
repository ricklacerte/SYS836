% EXERCICE 3 : Canal sélectif en fréquence et Applications aux canaux
% COST 207 et GSM/EDGE
% 1) Qu’est-ce qu’un canal sélectif en fréquence ? Expliquer


% 2) Applications COST207 : Les modèles de canal COST207 ont été normalisés pour
% permettre de simuler des systèmes de communication à l’aide d’un ensemble commun
% de modèles de canal. Quatre modèles de propagation sont définis : Rural Area (RA),
% Typical Urban Area (TU), Bad Urban Area (BU) et le Hilly Terrain (HT).
% Dans un premier temps, créer les spectres Doppler pour le modèle COST 207. Ensuite
% un canal de Rayleigh sera appliqué. Enfin, visualiser certaines propriétés du canal.
% Le profil en puissance des retards utilisé est le suivant :
% ? = [0 200 600 1600 2400 5000] ? 1?
% ?9
% ? = [?3 0 ? 2 ? 6 ? 8 ? 10]

% a) Pour une fréquence Doppler ?? = 10 ??, générer 50000 échantillons qui
% seront transmis sur un canal de Rayleigh à un rythme de 1 Msymbs/s. Vous
% utiliserez l’objet « rayleighchan » de Matlab.



% b) A l’aide d’une simulation appropriée, montrer que ce canal est sélectif en
% fréquence.



% 3) Applications GSM/EDGE : Plusieurs modèles de canaux GSM / EDGE sont basés
% sur les modèles de canaux COST 207, mais avec l’hypothèse que chaque Rayleighfading
% possède un spectre Doppler Jakes.

% a) A l’aide de la fonction « stdchan » de Matlab, construire un modèle
% GSM/EDGE avec les paramètres suivants :
% M = 8; % ordre de modulation
% NSamples = 1e4; Nombre d’échantillons
% Nframes = 6;
% Rsym = 9600; % Rythme symbole
% Rbit = Rsym * log2(M); % Rythme binaire
% Nos = 4; % facteur de suréchantillonnage
% ts = (1/Rbit) / Nos; % Période d’échantillonnage
% v = 120 * 1e3/3600; % Vitesse du mobile (m/s)
% fc = 1800e6; % Fréquence porteuse
% c = 3e8; % Vitesse de la lumière
% fd = v*fc/c; % Maximum Doppler de la composante diffuse

% b) Visualiser les spectres Doppler et scattering. Commenter
