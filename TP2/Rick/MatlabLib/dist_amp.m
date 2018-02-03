function [] = dist_amp(NAME, SIGNAL)
%DIST_AMP Create a graph of amplitude distribution
%   Detailed explanation goes here
HIST_AMP = figure('Name','Distribution de l''amplitude','NumberTitle','off');
histogram(abs(SIGNAL), 'Normalization','probability');
title(sprintf('Distribution de l''amplitude du signal %s',NAME));
xlabel('Amplitude du signal');
ylabel('Probabilité');
savefig(sprintf('%s_dist_amp.fig',NAME));
saveas(HIST_AMP,sprintf('%s_dist_amp.png',NAME));
end

