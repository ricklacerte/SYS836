EBNO=[0:30];
BER_ALAMOUTI = zeros(length(EBNO));

% Signal 
N= 10^6; % Number of Data
signal = randsrc(N,1,[0 1]);

%% ALAMOUTI BER %%
for i = 1:length(EBNO)

    % Modulated Signal
    modulator = comm.BPSKModulator; 
    mod_signal = modulator(signal);
    
    % TODO: Add Alamouti encoder
    %ostbc = comm.OSTBCEncoder('NumTransmitAntennas',2,'SymbolRate',1/2);
    %TX_SIGNAL = ostbc(mod_signal);
    TX_SIGNAL = mod_signal;

    % Received Signal
    AWGN = comm.AWGNChannel('EbNo',EBNO(i),'BitsPerSymbol',1);
    CHANNEL = comm.RayleighChannel();
    %CHANNEL = comm.MIMOChannel('NumTransmitAntennas',2,'NumReceiveAntennas',1);
    RX_SIGNAL = CHANNEL(AWGN(TX_SIGNAL));

    % Demodulated Signal
    demodulator = comm.BPSKDemodulator; 
    DEMOD_SIGNAL = demodulator(RX_SIGNAL(:,1));

    % BER Calculation
    [nb, ber] = biterr(signal,DEMOD_SIGNAL);
    BER_ALAMOUTI(i) = ber;
    
end

%% Calcul BER
BER_DIV1 = berfading(EBNO,'psk',2,1);
BER_DIV2 = berfading(EBNO,'psk',2,2);

%% Graphique
figure();
semilogy(EBNO,BER_DIV1,'b',...
         EBNO,BER_DIV2,'.r',...
         EBNO,BER_ALAMOUTI,'-o')
legend('BPSK (Tx=1, Rx=1)',...
       'BPSK (Tx=2, Rx=2)',...
       'BPSK Alamouti');
%title('BPSK')
xlabel('E_b/N_0 (dB)')
ylabel('BER')
grid on
