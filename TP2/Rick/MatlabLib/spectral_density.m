function [] = spectral_density(SIGNAL, FS, NAME)
%SPECTRAL_DENSITY Create a graph of Spectral Density
%   Detailed explanation goes here

% Densité spectrale de puissance de x(t)
v_fft = fftshift(fft(SIGNAL));
N = length(v_fft);

dsp_x = (1/(FS*N)) * abs(v_fft).^2; % DSP = |fft|^2 * T
freq = 0:FS/length(SIGNAL):FS;

plot(freq(1:length(freq)-1), dsp_x);
xlim([min(freq) max(freq)]);
ylim([min(dsp_x) max(dsp_x)]);
title(sprintf('Densité spectrale de %s',NAME));
xlabel('Freq(Hz)');
ylabel('Magnitude(dB)');

saveas (gcf, sprintf('%s_spectral_dens.png',NAME));

end

