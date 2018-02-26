function signal_NRZ = generateur_NRZ(L, Fs, bit_duration, value_off, value_on)
% Generate Random NRZ signal of Tb seconds 

bit_length_samples = round(bit_duration*Fs);
signal_NRZ = zeros(L*bit_length_samples,1);
bits_sequence = randsrc(L,1,[value_off value_on]);

for i= 1:length(bits_sequence)
    signal_NRZ( (i-1)*bit_length_samples +1 : (i)*bit_length_samples) = bits_sequence(i);
end

