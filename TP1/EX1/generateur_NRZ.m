
function signal_NRZ = generateur_NRZ(L, Fs)
% Generate Random NRZ signal of 1 us 
bit_length_sec = 1E-6;
bit_length_samples = bit_length_sec*Fs;

signal_NRZ = zeros(L*bit_length_samples,1);
bits_sequence = randsrc(L,1);
for i= 0:length(bits_sequence)-1
    signal_NRZ( i*bit_length_samples + 1 : i*bit_length_samples + 16) = bits_sequence(i+1);
end