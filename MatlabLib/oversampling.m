function OVSMPL_SIGNAL = oversampling(SIGNAL,M)
%OVERSAMPLING Summary of this function goes here
%   Detailed explanation goes here

L = length(SIGNAL);

OVSMPL_SIGNAL = zeros(L*M,1);

for i = 1:L
    for m = 1:M
        OVSMPL_SIGNAL((i-1)*M + m) = SIGNAL(i); 
    end
end

end

