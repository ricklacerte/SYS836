addpath(genpath('..\..\MatlabLib'));

% Data
N = 2;
FS = 4;
SIGNAL = binary_generator(N,FS,1,-1,1);
subplot(3,1,1)
plot(SIGNAL)

% Coding sequence
N = 10;
SEQ = randsrc(N,1,[1 -1]);
subplot(3,1,2)
plot(SEQ)

% Coded Data
RESULT = SEQ.*SIGNAL
subplot(3,1,3)
plot(RESULT)


