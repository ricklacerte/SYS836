addpath(genpath('..\..\MatlabLib'));

L=10;
M=4;
N = 8;
TE=1;   % HACK : unit�?

TC=M*TE;
TB=N*TC;
RE= 1/TE;
Fs = RE * M;

%1) G�n�rer et afficher un train
% binaire al�atoire de longueur L = 10.
% Data
DATA = randsrc(L,1,[1 -1]);

plot(DATA)
title(sprintf('Train binaire al�atoire de longueur L=%d',L));
xlabel("Samples");
ylabel("Value");
saveas (gcf, "train_bin.png");

% 2) G�n�rer et afficher une s�quence d��talement de longueur N= 8.
% Coding sequence

%TC=TB/N;
SEQ = randsrc(N,1,[1 -1]);

plot(SEQ)
title(sprintf('S�quence al�atoire de longueur N=%d',N));
xlabel("Samples");
ylabel("Value");
saveas (gcf, "sequence.png");

% 3) Etaler le signal et afficher le signal r�sultant.
CODED_SIG = spread_spectrum(DATA,SEQ);

plot(CODED_SIG)
title('�talement du signal');
xlabel("Samples");
ylabel("Value");
saveas (gcf, "spread.png");


% 4) En utilisant une fonction porte, faire une mise en forme du signal �tal�. Afficher le
% graphique obtenu.
CODED_SIG_OVS = oversampling(CODED_SIG,M);

plot(CODED_SIG_OVS)
title('Signal sur�chantillon� (fonction porte)');
xlabel("Samples");
ylabel("Value");
saveas (gcf, "porte.png");

% 5) Afficher la r�ponse impulsionnelle du filtre en racine de cosinus sur�lev� avec un rolloff
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

% 6) En utilisant le filtre en racine de cosinus sur�lev�, faire une mise en forme du signal
% �tal�. Afficher le graphique obtenu.

yo = rctFilt(CODED_SIG);
plot(yo)
title('Signal � la sortie du Filtre cosinus sur�lev�');
xlabel("temps");
ylabel("Amplitude");
saveas (gcf, "cosined.png");


