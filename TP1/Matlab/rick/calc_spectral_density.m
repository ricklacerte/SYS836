
function calc_spectral_density( x_data, Fs, graph_name)
% look for fft_shift

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
v_fft = fft(x_data);
N = length(v_fft);

v_fft = v_fft(1:N/2+1);
dsp_x = (1/(Fs*N)) * abs(v_fft).^2; % DSP = |fft|^2 * T
dsp_x(1:length(dsp_x)) = 2*dsp_x(1:length(dsp_x)); % fft (partie négative)

freq = 0:Fs/length(x_data):Fs/2;

plot(freq, convert_to_db(dsp_x));
xlabel('Freq(Hz)');
ylabel('DSP de x(t) en dB');


if (strcmp(graph_name,'') == false)
  saveas (1, graph_name);
end
end