function [] = dist_phase(NAME,SIGNAL)
%DIST_PHASE Summary of this function goes here
%   Detailed explanation goes here
HIST_AMP = figure('Name','Distribution de la phase','NumberTitle','off');
histogram(angle(SIGNAL), 'Normalization','probability');
title(sprintf('Distribution de la phase du signal %s',NAME));
xlabel('Phase du signal');
ylabel('Probabilité');
savefig(sprintf('%s_dist_phase.fig',NAME));
saveas(HIST_AMP,sprintf('%s_dist_phase.png',NAME));
end

