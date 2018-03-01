function SPREAD_SIGNAL = spread_spectrum(DATA,SEQ)
%spread_spectrum Summary of this function goes here
%   Detailed explanation goes here

SPREAD_SIGNAL = zeros(length(DATA)*length(SEQ),1);
N = length(SEQ);
L = length(DATA);

for i=1:L
    for n=1:N
        SPREAD_SIGNAL((i-1)*N + n) = DATA(i)*SEQ(n);
    end
end

