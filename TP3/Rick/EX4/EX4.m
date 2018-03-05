% 1) G�n�rer et afficher une s�quence ML de taille N= 63.
clear all 
close all

%N = 2^m-1
N=63;
M=ceil(log2(N-1))

% https://www.mathworks.com/help/comm/ref/pnsequencegenerator.html
PN = comm.PNSequence('Polynomial',[6 1 0], ...
    'SamplesPerFrame',63,'InitialConditions',[0 0 0 0 0 1]);
ML = PN();

% 2) Trouver la fonction d�autocorr�lation et afficher le graphique correspondant � la
% s�quence g�n�r�e.

figure();
[x,xc] = xcorr(ML);
plot(x);
title('Auto-corr�lation de la s�quence ML');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "ML_autocorr.png");

% 3) G�n�rer deux s�quences de paires pr�f�r�es suivant un code de Gold de taille N= 63.
pref1 = ML;
pref2 = zeros(N,1);
for i = 1:N
    ML = circshift(ML,M);
    pref2(i)=ML(1);
end    
[x,xc]=xcorr(pref1,pref2);
figure();
plot(x);

% 4) Afficher la fonction d�inter-corr�lation de ces paires pr�f�r�es.

title('Auto-corr�lation de la s�quence Gold');
xlabel('lags');
ylabel('auto-correlation');
saveas (gcf, "Gold_autocorr.png");

% 5) Comparer les s�quences de Gold et ML.
