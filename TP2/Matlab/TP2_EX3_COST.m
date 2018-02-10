% 1) Qu’est-ce qu’un canal sélectif en fréquence ? Expliquer 
%% voir EX1.3.
% https://www.mathworks.com/help/comm/examples/cost-207-and-gsm-edge-channel-models.html
% 2) COST 207
% créer les spectres Doppler pour le modèle COST 207.
% Ensuite un canal de Rayleigh sera appliqué. Enfin, visualiser certaines propriétés du canal.
% Le profil en puissance des retards utilisé est le suivant :
% ? = [0 200 600 1600 2400 5000] ? 1??9
% ? = [?3 0 ? 2 ? 6 ? 8 ? 10]
% canal de rayleigh
% fd = 10 Hz, 50000 échantillons, 1Msym/s
% montrer que canal est sélectif en fréquence

% sim params
M = 4;                      % Modulation order
psk4Mod = comm.PSKModulator(M, 'PhaseOffset', 0); % PSK Modulator System object
%Rsym = 9600;
Rsym = 125000;                % Input symbol rate
Rbit = Rsym * log2(M);      % Input bit rate
Nos = 4;                    % Oversampling factor
ts = (1/Rbit) / Nos;        % Input sample period (1Msymb/s)

% v = 120 * 1e3/3600;         % Mobile speed (m/s)
% fc = 1800e6;                % Carrier frequency
% c = 3e8;                    % Speed of light in free space
% fd = v*fc/c;                % Maximum Doppler shift of diffuse component
fd = 10;

chan = rayleighchan(ts, fd);
% Assign profile-specific properties to channel object.
chan.PathDelays = [0 200 600 1600 2400 5000] * 1e-9;
chan.AvgPathGaindB = [-3 0 -2 -6 -8 -10];

chan.StoreHistory = 1;
chan.ResetBeforeFiltering = 0;
chan.NormalizePathGains = 1;

% simulation
Nframes = 16;
Nsamples = 5e4;
for iFrames = 1:Nframes
    y = filter(chan, psk4Mod(randi([0 M-1],Nsamples,1)));
    plot(chan);
    % Select the frequency response as the current visualization.
    if iFrames == 1, channel_vis(chan, 'visualization', 'fr'); end
end
%   y = filter(chan, psk4Mod(randi([0 M-1],Nsamples,1)));
sa = dsp.SpectrumAnalyzer('SampleRate',1/ts,'SpectralAverages',10);
step(sa,y)

