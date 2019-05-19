%% Generate matrix of scatter plots for each of the features 
% Top 250 songs by ranking
tbl = working_table(1:250,:);

rank = table2array(tbl(:,11));
danceability = table2array(tbl(:,4));
duration = table2array(tbl(:,5));
liveliness = table2array(tbl(:,6));
tempo = table2array(tbl(:,7));

% Column in order of rank danceability duration liveliness tempo as
% indicated below
foi = [rank danceability duration liveliness tempo];
[r1 c1] = size(foi);

% Label names for the axis
label_names = {'rank', 'danceability', 'duration', 'liveliness', 'tempo'};

% Generate the plots for each of the features compared to each other
for x = 1:c1
    for y = 1:x
        subplot(5, 5, 5 * (x - 1) + y);
        scatter(foi(:,x), foi(:,y), 'b');
        hold on
        xlabel(label_names{x})
        ylabel(label_names{y})
        hold off
    end
end

