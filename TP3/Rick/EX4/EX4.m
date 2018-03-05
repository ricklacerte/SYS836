% 1) Générer et afficher une séquence ML de taille N= 63.
clear all 
close all

%N = 2^m-1
N=63;
M=ceil(log2(N-1))

% https://www.mathworks.com/help/comm/ref/pnsequencegenerator.html
PN = comm.PNSequence('Polynomial',[6 1 0], ...
    'SamplesPerFrame',63,'InitialConditions',[0 0 0 0 0 1]);
ML = PN();

% 2) Trouver la fonction d’autocorrélation et afficher le graphique correspondant à la
% séquence générée.

figure();
[x,xc] = xcorr(ML);
plot(x);
title('Auto-corrélation de la séquence ML');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "ML_autocorr.png");

% 3) Générer deux séquences de paires préférées suivant un code de Gold de taille N= 63.
pref1 = ML;
pref2 = zeros(N,1);
for i = 1:N
    ML = circshift(ML,M);
    pref2(i)=ML(1);
end    
[x,xc]=xcorr(pref1,pref2);
figure();
plot(x);

% 4) Afficher la fonction d’inter-corrélation de ces paires préférées.

title('Auto-corrélation de la séquence Gold');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "Gold_autocorr.png");

% 5) Comparer les séquences de Gold et ML.
