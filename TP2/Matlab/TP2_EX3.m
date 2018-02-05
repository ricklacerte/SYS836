% 1) Qu�est-ce qu�un canal s�lectif en fr�quence ? Expliquer 
%% voir EX1.3.

% https://www.mathworks.com/help/comm/examples/cost-207-and-gsm-edge-channel-models.html
% 2) COST 207
% cr�er les spectres Doppler pour le mod�le COST 207.
% canal de rayleigh
% ? = [0 200 600 1600 2400 5000] ? 1??9
% ? = [?3 0 ? 2 ? 6 ? 8 ? 10]
% fd = 10 Hz, 50000 �chantillons, 1Msym/s
% montrer que canal est s�lectif en fr�quence


% 3) GSM/EDGE
% stdchan
M = 8; % ordre de modulation
NSamples = 1e4; % Nombre d��chantillons
Nframes = 6;
Rsym = 9600; % Rythme symbole
Rbit = Rsym * log2(M); % Rythme binaire
Nos = 4; % facteur de sur�chantillonnage
ts = (1/Rbit) / Nos; % P�riode d��chantillonnage
v = 120 * 1e3/3600; % Vitesse du mobile (m/s)
fc = 1800e6; % Fr�quence porteuse
c = 3e8; % Vitesse de la lumi�re
fd = v*fc/c; % Maximum Doppler de la composante diffuse

chan = stdchan(ts, fd, 'gsmEQx6');

chan.StoreHistory = 1;
chan.ResetBeforeFiltering = 0;
chan.NormalizePathGains = 1;

psk8Mod = comm.PSKModulator(M, 'PhaseOffset', 0); % PSK Modulator System object

for iFrames = 1:Nframes
    y = filter(chan, psk8Mod(randi([0 M-1],NSamples,1)));
    plot(chan);
    if iFrames == 1, channel_vis(chan, 'visualization', 'scattering'); end
end

% visualiser spectres doppler et scattering. Commenter.
