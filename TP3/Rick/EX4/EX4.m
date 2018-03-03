% 1) Générer et afficher une séquence ML de taille N= 63.
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


% 2) Trouver la fonction d’autocorrélation et afficher le graphique correspondant à la
% séquence générée.

figure();
hold on
for i = 1:N
    [xc,lags] = xcorr(ML(:,i),ML(:,i),'coeff');
    plot(lags,xc);
end
title('Auto-corrélation de la séquence ML');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "ML_autocorr.png");

% 3) Générer deux séquences de paires préférées suivant un code de Gold de taille N= 63.
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

% 4) Afficher la fonction d’inter-corrélation de ces paires préférées.

figure();
hold on
for i = 1:N
    [xc,lags] = xcorr(GOLD(:,i),GOLD(:,i));
    plot(lags,xc);
end
title('Auto-corrélation de la séquence Gold');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "Gold_autocorr.png");

% 5) Comparer les séquences de Gold et ML.
