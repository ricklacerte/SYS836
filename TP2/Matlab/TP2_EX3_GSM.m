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
