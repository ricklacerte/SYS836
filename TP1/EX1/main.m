L = 1024;
fs = 16E6;
signal = generateur_NRZ(L,fs);

calc_spectral_density(signal,fs, 'densité spectrale')