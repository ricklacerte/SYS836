function [] = constellation(NAME, SIGNAL)
%CONSTELLATION Creates a constellation graph of the SIGNAL
scatterplot(SIGNAL)
title(sprintf('Constellation du Signal %s',NAME));
xlabel('In-Phase');
ylabel('Quadrature');
savefig(sprintf('%s_constellation.fig',NAME));
saveas(gcf,sprintf('%s_constellation.png',NAME));
end

