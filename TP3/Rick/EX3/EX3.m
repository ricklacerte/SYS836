addpath(genpath('..\..\..\MatlabLib'));
NB_USERS = 10;
L = 10;
M=4


% 2) G�n�rer et afficher chacun des trains binaires des 10 utilisateurs.
figure();

DATA = zeros(NB_USERS, L);
for i = 1:NB_USERS
    DATA(i,:) = randsrc(L,1,[1 -1]);
    
    subplot(NB_USERS,1,i);
    plot(DATA(i,:));
    if (i == 1)
        title(sprintf("Train de donn�es pour %d utilisateurs", NB_USERS));
    end
    
    if (i == ceil(NB_USERS/2))
        ylabel("Valeur");
    end
    
    if (i == NB_USERS)
       xlabel("�chantillons");
    end 
end
saveas (gcf, "train_bin.png");

% 3) Expliquer les s�quences de Walsh Hadamard

% 4) A partir des s�quences de Walsh Hadamard, constituer le m�lange des signaux et �taler
% le signal r�sultant. Effectuer une mise en forme du signal �tal� avec la fonction porte
% donn�e dans l�exercice 2. Afficher le signal r�sultant.

% Matrice Walsh-Hadamard
HAD_SIZE = 2^ceil(log2(NB_USERS));
CODE = hadamard(HAD_SIZE);

% Spread spectrum for each users
figure();
CODED_SIGNAL = zeros(NB_USERS,L*HAD_SIZE);
for i = 1:NB_USERS
    CODED_SIGNAL(i,:) = spread_spectrum(DATA(i,:),CODE(i+1,:));
    
    subplot(NB_USERS,1,i);
    plot(CODED_SIGNAL(i,:));
    if (i == 1)
        title(sprintf("Signal �tal� pour %d utilisateurs", NB_USERS));
    end
    
    if (i == ceil(NB_USERS/2))
        ylabel("Valeur");
    end
    
    if (i == NB_USERS)
       xlabel("�chantillons");
    end 
end
saveas (gcf, "etalement.png");

% Sur�chantillonage avec la fonction porte
figure();
CODED_SIG_OVS = zeros(NB_USERS,L*HAD_SIZE*M);
for i = 1:NB_USERS
    CODED_SIG_OVS(i,:) = oversampling(CODED_SIGNAL(i,:),M);
    
    subplot(NB_USERS,1,i);
    plot(CODED_SIG_OVS(i,:));
    if (i == 1)
        title(sprintf("Signal sur�chantillon� �tal� pour %d utilisateurs", NB_USERS));
    end
    
    if (i == ceil(NB_USERS/2))
        ylabel("Valeur");
    end
    
    if (i == NB_USERS)
       xlabel("�chantillons");
    end 
end
saveas (gcf, "surechantillon.png");