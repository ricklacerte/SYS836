% 1) G�n�rer et afficher une s�quence ML de taille N= 63.

%N = 2^m-1
N=63;
M=ceil(log2(N-1))

% https://www.mathworks.com/help/comm/ref/pnsequencegenerator.html
PN = comm.PNSequence('Polynomial',[6 5 0], ...
    'SamplesPerFrame',M,'InitialConditions',[0 0 0 0 0 1]);
x1 = PN();
x1(1:M)

for i = 1:63
    x1 = PN();
    x1(1:M)'
    
    %TODO: Put X1 in matrix and correlate the MAtrix [63 x x1(1:M)]
    [xc,lags] = xcorr(x1)
end


% 2) Trouver la fonction d�autocorr�lation et afficher le graphique correspondant � la
% s�quence g�n�r�e.

[xc,lags] = xcorr(x1)

% 3) G�n�rer deux s�quences de paires pr�f�r�es suivant un code de Gold de taille N= 63.

% 4) Afficher la fonction d�inter-corr�lation de ces paires pr�f�r�es.

% 5) Comparer les s�quences de Gold et ML.
