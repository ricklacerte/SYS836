% 1) G�n�rer et afficher une s�quence ML de taille N= 63.
clear all 
close all

%N = 2^m-1
N=63;
M=ceil(log2(N-1))

% https://www.mathworks.com/help/comm/ref/pnsequencegenerator.html
PN = comm.PNSequence('Polynomial',[6 5 0], ...
    'SamplesPerFrame',M,'InitialConditions',[0 0 0 0 0 1]);
ML = [];

for i = 1:N
    x1 = PN();    
    ML = [ML,x1];
end


% 2) Trouver la fonction d�autocorr�lation et afficher le graphique correspondant � la
% s�quence g�n�r�e.

figure();
hold on
for i = 1:N
    [xc,lags] = xcorr(ML(:,i),ML(:,i),'coeff');
    plot(lags,xc);
end
title('Auto-corr�lation de la s�quence ML');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "ML_autocorr.png");

% 3) G�n�rer deux s�quences de paires pr�f�r�es suivant un code de Gold de taille N= 63.
gold_gen = comm.GoldSequence('FirstPolynomial',[6 5 0],...
    'SecondPolynomial',[6 5 0],...
    'FirstInitialConditions',[0 0 0 0 0 1],...
    'SecondInitialConditions',[0 0 0 0 0 1],...
    'SamplesPerFrame',M);

GOLD = [];
for i = 1:N
    x = gold_gen()    
    GOLD = [GOLD,x];
end

% 4) Afficher la fonction d�inter-corr�lation de ces paires pr�f�r�es.

figure();
hold on
for i = 1:N
    [xc,lags] = xcorr(GOLD(:,i),GOLD(:,i));
    plot(lags,xc);
end
title('Auto-corr�lation de la s�quence Gold');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "Gold_autocorr.png");

% 5) Comparer les s�quences de Gold et ML.
