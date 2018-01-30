chan = rayleighchan(1/10e3, 10);
x = randsrc(100000,1,[0 1]);
dbspkMod = comm.DBPSKModulator;
dpskSig = dbspkMod(x);
y = filter(chan, dpskSig);
figure('Name','Distribution de l''amplitude','NumberTitle','off');
hist(abs(y), 1000);
figure('Name','Distribution de la phase','NumberTitle','off');
hist(angle(y), 1000);
