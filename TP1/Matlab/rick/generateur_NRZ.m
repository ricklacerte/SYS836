
function samples = generateur_NRZ(L)
% Generate NRZ 
%samples =  randsrc(1,L);
s = randsrc(L,1,[-1 1]);
samples =zeros(L*16,1);
for i= 0:length(s)-1
    samples(1+i*16:16+i*16) = s(i+1);
end