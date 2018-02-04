function [] = dist_amp(NAME, SIGNAL)
%DIST_AMP Create a graph of amplitude distribution
%   Detailed explanation goes here
NAME=cellstr(NAME);
HIST_AMP = figure('Name','Distribution de l''amplitude','NumberTitle','off');
[n_rows,n_columns] = size(SIGNAL);

hold on
for signal_id = 1:n_columns
    histogram(abs(SIGNAL(:,signal_id)), 'Normalization','probability');
end
hold off

title(sprintf('Distribution de l''amplitude du signal %s',strjoin(NAME, ',')));
legend(NAME);
xlabel('Amplitude du signal');
ylabel('Probabilité');
savefig(sprintf('%s_dist_amp.fig',strjoin(NAME, '_')));
saveas(HIST_AMP,sprintf('%s_dist_amp.png',strjoin(NAME, '_')));
end

