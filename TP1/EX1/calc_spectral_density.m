
function calc_spectral_density( x_data, Fs, graph_name)

% signal x(t)
subplot(2,1,1);
time_s= (1:length(x_data))*(1/Fs);
plot(time_s,x_data);
xlim([0 time_s(length(time_s))]);
ylim([min(x_data) max(x_data)]);
xlabel('time(sec)');
ylabel('x(t)');

% Densité spectrale de puissance de x(t)
subplot(2,1,2);
v_fft = fftshift(fft(x_data));
N = length(v_fft);

dsp_x = (1/(Fs*N)) * abs(v_fft).^2; % DSP = |fft|^2 * T
freq = 0:Fs/length(x_data):Fs-1;

plot(freq, dsp_x);
xlim([min(freq) max(freq)]);
ylim([min(dsp_x) max(dsp_x)]);
xlabel('Freq(Hz)');
ylabel('DSP de x(t) en dB');

if (strcmp(graph_name,'') == false)
  saveas (1, graph_name, 'jpg');
end
end