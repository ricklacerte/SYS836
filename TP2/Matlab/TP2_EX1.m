% 1) Pour une fr�quence Doppler Fd = 10 Hz, g�n�rer 100000 �chantillons qui seront
% transmis sur un canal de Rayleigh � un rythme de 10 ksymbs/s. Vous utiliserez l�objet
% � rayleighchan � de Matlab.
Fd = 10;
Fs = 1/10e3;
chan = rayleighchan(Fs, Fd);
x = randsrc(100000,1,[0 1]);
dbspkMod = comm.DBPSKModulator;
dpskSig = dbspkMod(x);

% 2) Avec la fonction � hist �, montrer que l�amplitude de ces �chantillons suit une
% distribution de probabilit� de Rayleigh et que la phase suit une distribution uniforme.
y = filter(chan, dpskSig);
figure('Name','Distribution de l''amplitude','NumberTitle','off');
hist(10*log10(abs(y)), 1000);
figure('Name','Distribution de la phase','NumberTitle','off');
hist(angle(y), 1000);

% 3) A l�aide d�une simulation appropri�e, montrer que ce canal n�est pas s�lectif en
% fr�quence.
sa = dsp.SpectrumAnalyzer('SampleRate',fs,'SpectralAverages',10);
step(sa,y)

% dur�e symbole > RI du canal (delay spread) == pas ISI
% ou
% eye diagram
% ou
% r�ponse fr�quentielle plate

% 4) Rappeler la d�finition de temps de coh�rence et bande de coh�rence d�un canal.
% La bande de coh�rence == 1/Max excess delay == 1/inf =~ 0
% depends on the multipath spread or, equivalently, on the coherence bandwidth
% of the channel relative to the transmitted signal bandwidth W.
% Le temps de coh�rence == 1/Bd = 1/(2*Fd)
% Additional distortion is caused by the time variations in C( f ; t).
% depends on 
% the time variations of the channel, which are grossly characterized by
% the coherence time (Delata t)c or, equivalently, by the Doppler spread Bd .
% This type of distortion is evidenced as a variation in the received
% signal strength, and has been termed fading.
% Quelles sont les valeurs du temps de coh�rence et de la bande de coh�rence de ce
% canal ?
% ????

% 5) Pour une fr�quence Doppler Fd = [50 100 150] Hz, montrer l�influence de Fd sur
% l�amplitude des �chantillons.
for Fd=[50 100 150]
    chan = rayleighchan(Fs, Fd);
    y = filter(chan, dpskSig);
    legend = sprintf('Distribution de l''amplitude Fd = %d',fd);
    figure('Name',legend,'NumberTitle','off');
    plot(y);
    % saveas(histogram(10*log10(abs(y)), 1000),sprintf('rayleighchan_amp_%d.png',fd)); 
end
% l'amplitude des �chantillons augmente

% 6) A l�aide d�une simulation Matlab ou Simulink, r�aliser des courbes de performances
% pour la modulation OQPSK et avec une diversit� L= [1 2 4]. Commenter
% L = ?? nombre de porteuses, espac�es d'au moins 1 bande de coh�rence.?
% OQPSK
EbNo=0:2:18;
ber = zeros(length(EbNo),3);
for L=[1 2 4]
    ber(:,L) = berfading(EbNo,'oqpsk',L);
    semilogy(EbNo,ber,'b')
    text(16, 0.02, sprintf('L=%d',1))
    text(16, 1e-5, sprintf('L=%d',4))
    title('OQPSK over fading channel with diversity order 1, 2 & 4')
    xlabel('E_b/N_0 (dB)')
    ylabel('BER')
    grid on
    %saveas(histogram(10*log10(abs(y)), 1000),sprintf('rayleighchan_amp_%d.png',fd)); 
end
% L = [1 2 4]; % ??
% Fs = 1/10e3;
% Fd = 10;
% tx = randsrc(100000,1,[0 1]);
% oqpskMod = comm.OQPSKModulator;
% oqpskDemod = comm.OQPSKDemodulator(oqpskMod);
% oqpskSig = oqpskMod(tx);
% chan = rayleighchan(Fs, Fd);
% y = filter(chan, oqpskSig);
% rx = oqpskDemod(y);
% errorCalc = comm.ErrorRate;
% BER = errorCalc(rx, tx);
