addpath(genpath('..\..\MatlabLib'));

L=10;
M=4;
N = 8;
TE=1;   % HACK : unité?

TC=M*TE;
TB=N*TC;
RE= 1/TE;
Fs = RE * M;

%1) Générer et afficher un train
% binaire aléatoire de longueur L = 10.
% Data
DATA = randsrc(L,1,[1 -1]);

plot(DATA)
title(sprintf('Train binaire aléatoire de longueur L=%d',L));
xlabel("Samples");
ylabel("Value");
saveas (gcf, "train_bin.png");

% 2) Générer et afficher une séquence d’étalement de longueur N= 8.
% Coding sequence

%TC=TB/N;
SEQ = randsrc(N,1,[1 -1]);

plot(SEQ)
title(sprintf('Séquence aléatoire de longueur N=%d',N));
xlabel("Samples");
ylabel("Value");
saveas (gcf, "sequence.png");

% 3) Etaler le signal et afficher le signal résultant.
CODED_SIG = spread_spectrum(DATA,SEQ);

plot(CODED_SIG)
title('Étalement du signal');
xlabel("Samples");
ylabel("Value");
saveas (gcf, "spread.png");


% 4) En utilisant une fonction porte, faire une mise en forme du signal étalé. Afficher le
% graphique obtenu.
CODED_SIG_OVS = oversampling(CODED_SIG,M);

plot(CODED_SIG_OVS)
title('Signal suréchantilloné (fonction porte)');
xlabel("Samples");
ylabel("Value");
saveas (gcf, "porte.png");

% 5) Afficher la réponse impulsionnelle du filtre en racine de cosinus surélevé avec un rolloff
% factor ?=0.3.
Nsym = 6;           % Filter span in symbol durations HACK: i decide?
beta = 0.3;         % Roll-off factor
sampsPerSym = M;    % Upsampling factor

rctFilt = comm.RaisedCosineTransmitFilter(...
  'Shape',                  'Normal', ...
  'RolloffFactor',          beta, ...
  'FilterSpanInSymbols',    Nsym, ...
  'OutputSamplesPerSymbol', sampsPerSym)

% Normalize to obtain maximum filter tap value of 1
b = coeffs(rctFilt);
rctFilt.Gain = 1/max(b.Numerator);

% Visualize the impulse response
fvtool(rctFilt, 'Analysis', 'impulse')

% 6) En utilisant le filtre en racine de cosinus surélevé, faire une mise en forme du signal
% étalé. Afficher le graphique obtenu.

yo = rctFilt(CODED_SIG);
plot(yo)
title('Signal à la sortie du Filtre cosinus surélevé');
xlabel("temps");
ylabel("Amplitude");
saveas (gcf, "cosined.png");


