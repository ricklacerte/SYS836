% train binaire al�atoire de longueur L=10
L=10;
a = randsrc(L,1,[-1 1]);
% s�quence d'�talement de longueur N=8
N=8;
p = randsrc(N,1,[-1 1]);
% �taler le signal
aUp = reshape([a';a';a';a';a';a';a';a'],[],1);
e = zeros(L*N,1);
for n=1:length(e)
    for i=1:length(p)
        if ((n-i)>0)
            sum = p(i)*aUp(n-i);
        end
    end
end
