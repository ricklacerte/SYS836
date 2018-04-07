% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script for computing the BER for BPSK modulation in a
% Rayleigh fading channel with Alamouti Space Time Block Coding
% Two transmit antenna, Two Receive antenna

% clear
N = 10^6; % number of bits or symbols
Eb_N0_dB = [0:30]; % multiple Eb/N0 values
nRx = 2; 

for ii = 1:length(Eb_N0_dB)

    % Transmitter
    ip = rand(1,N)>0.5; % generating 0,1 with equal probability
    s = 2*ip-1; % BPSK modulation 0 -> -1; 1 -> 0

    % Alamouti STBC 
    sCode = 1/sqrt(2)*kron(reshape(s,2,N/2),ones(1,2)) ;

    % channel
    
    h = 1/sqrt(2)*[randn(nRx,N) + j*randn(nRx,N)]; % Rayleigh channel
    n = 1/sqrt(2)*[randn(nRx,N) + j*randn(nRx,N)]; % white gaussian noise, 0dB variance

    y = zeros(nRx,N);
    yMod = zeros(nRx*2,N);
    hMod = zeros(nRx*2,N);
    for kk = 1:nRx

        hMod = kron(reshape(h(kk,:),2,N/2),ones(1,2)); % repeating the same channel for two symbols    
        hMod = kron(reshape(h(kk,:),2,N/2),ones(1,2));
        temp = hMod;
        hMod(1,[2:2:end]) = conj(temp(2,[2:2:end])); 
        hMod(2,[2:2:end]) = -conj(temp(1,[2:2:end]));

        % Channel and noise Noise addition
        y(kk,:) = sum(hMod.*sCode,1) + 10^(-Eb_N0_dB(ii)/20)*n(kk,:);

        % Receiver
        yMod([2*kk-1:2*kk],:) = kron(reshape(y(kk,:),2,N/2),ones(1,2));
    
        % forming the equalization matrix
        hEq([2*kk-1:2*kk],:) = hMod;
        hEq(2*kk-1,[1:2:end]) = conj(hEq(2*kk-1,[1:2:end]));
        hEq(2*kk,  [2:2:end]) = conj(hEq(2*kk,  [2:2:end]));

    end

    % equalization 
    hEqPower = sum(hEq.*conj(hEq),1);
    yHat = sum(hEq.*yMod,1)./hEqPower; % [h1*y1 + h2y2*, h2*y1 -h1y2*, ... ]
    yHat(2:2:end) = conj(yHat(2:2:end));

    % receiver - hard decision decoding
    ipHat = real(yHat)>0;

    % counting the errors
    nErr(ii) = size(find([ip- ipHat]),2);

end

simBer = nErr/N; % simulated ber
EbN0Lin = 10.^(Eb_N0_dB/10);
theoryBer_nRx1 = 0.5.*(1-1*(1+1./EbN0Lin).^(-0.5)); 

p = 1/2 - 1/2*(1+1./EbN0Lin).^(-1/2);
theoryBerMRC_nRx2 = p.^2.*(1+2*(1-p)); 

pAlamouti = 1/2 - 1/2*(1+2./EbN0Lin).^(-1/2);
theoryBerAlamouti_nTx2_nRx1 = pAlamouti.^2.*(1+2*(1-pAlamouti)); 

close all
figure (2)
semilogy(Eb_N0_dB,theoryBer_nRx1,'bp-','LineWidth',2);
hold on
semilogy(Eb_N0_dB,theoryBerMRC_nRx2,'kd-','LineWidth',2);
semilogy(Eb_N0_dB,theoryBerAlamouti_nTx2_nRx1,'c+-','LineWidth',2);
semilogy(Eb_N0_dB,simBer,'mo-','LineWidth',2);
axis([0 25 10^-5 0.5])
%grid on
legend('theory (nTx=1,nRx=1)', 'theory (nTx=1,nRx=2, MRC)', 'theory (nTx=2, nRx=1, Alamouti)', 'sim (nTx=2, nRx=2, Alamouti)');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');
title('BER for BPSK modulation with 2Tx, 2Rx Alamouti STBC (Rayleigh channel)');