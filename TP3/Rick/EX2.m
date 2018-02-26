addpath(genpath('..\..\MatlabLib'));

% Data
L=10;
M = 4;
SIGNAL = binary_generator(L,M,1,-1,1);
plot(SIGNAL)

% Coding sequence
N = 10;
SEQ = randsrc(N,1,[1 -1]);
subplot(3,1,2)
plot(SEQ)