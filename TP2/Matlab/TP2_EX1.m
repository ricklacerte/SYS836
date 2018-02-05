% 1) Pour une fréquence Doppler Fd = 10 Hz, générer 100000 échantillons qui seront
% transmis sur un canal de Rayleigh à un rythme de 10 ksymbs/s. Vous utiliserez l’objet
% « rayleighchan » de Matlab.
Fd = 10;
Fs = 1/10e3;
chan = rayleighchan(Fs, Fd);
x = randsrc(100000,1,[0 1]);
dbspkMod = comm.DBPSKModulator;
dpskSig = dbspkMod(x);

% 2) Avec la fonction « hist », montrer que l’amplitude de ces échantillons suit une
% distribution de probabilité de Rayleigh et que la phase suit une distribution uniforme.
y = filter(chan, dpskSig);
figure('Name','Distribution de l''amplitude','NumberTitle','off');
hist(10*log10(abs(y)), 1000);
figure('Name','Distribution de la phase','NumberTitle','off');
hist(angle(y), 1000);

% 3) A l’aide d’une simulation appropriée, montrer que ce canal n’est pas sélectif en
% fréquence.
sa = dsp.SpectrumAnalyzer('SampleRate',fs,'SpectralAverages',10);
step(sa,y)

% durée symbole > RI du canal (delay spread) == pas ISI
% ou
% eye diagram
% ou
% réponse fréquentielle plate

% 4) Rappeler la définition de temps de cohérence et bande de cohérence d’un canal.
% Quelles sont les valeurs du temps de cohérence et de la bande de cohérence de ce
% canal ?
% ????

% 5) Pour une fréquence Doppler Fd = [50 100 150] Hz, montrer l’influence de Fd sur
% l’amplitude des échantillons.
for Fd=[50 100 150]
    chan = rayleighchan(Fs, Fd);
    y = filter(chan, dpskSig);
    legend = sprintf('Distribution de l''amplitude Fd = %d',fd);
    figure('Name',legend,'NumberTitle','off');
    saveas(histogram(10*log10(abs(y)), 1000),sprintf('rayleighchan_amp_%d.png',fd)); 
end
% l'amplitude des échantillons augmente

% 6) A l’aide d’une simulation Matlab ou Simulink, réaliser des courbes de performances
% pour la modulation OQPSK et avec une diversité L= [1 2 4]. Commenter
% L = ?? nombre de porteuses, espacées d'au moins 1 bande de cohérence.?
% OQPSK
L = [1 2 4]; % ??
Fs = 1/10e3;
Fd = 10;
tx = randsrc(100000,1,[0 1]);
oqpskMod = comm.OQPSKModulator;
oqpskDemod = comm.OQPSKDemodulator(oqpskMod);
oqpskSig = oqpskMod(tx);
chan = rayleighchan(Fs, Fd);
y = filter(chan, oqpskSig);
rx = oqpskDemod(y);
errorCalc = comm.ErrorRate;
BER = errorCalc(rx, tx);
