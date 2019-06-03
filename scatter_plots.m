%% Generate matrix of scatter plots for each of the features 
% Top 250 songs by ranking
tbl = working_table(:,:);

% Extracting columns containing our features of interest into individual
% columns for analysis
rank = table2array(tbl(:,11));
danceability = table2array(tbl(:,4));
duration = table2array(tbl(:,5));
liveliness = table2array(tbl(:,6));
tempo = table2array(tbl(:,7));

% Column in order of rank danceability duration liveliness tempo as
% indicated below
foi = [rank danceability duration liveliness tempo];

% Filter the data down to songs only included in the top 100.
index = find(foi(:,1) > 100);
foi = foi(1:index(1,1),:);

% Find the index in which the different classes occur in the unsplit matrix
% containing all songs ranked 1 - 100.
index_class_1 = find(foi(:,1) > 25);
index_class_2 = find(foi(:,1) > 50);
index_class_3 = find(foi(:,1) > 75);

class_1 = foi(1:index_class_1(1,1) - 1,:);
class_2 = foi(index_class_1(1,1):index_class_2(1,1) - 1,:);
class_3 = foi(index_class_2(1,1):index_class_3(1,1) - 1,:);
class_4 = foi(index_class_3(1,1):end,:);

% Filting the classes for the scatter plots to smaller sections from which
% trends should be identifiable.
class_1_redu = class_1(1:50,:);
class_2_redu = class_2(1:50,:);
class_3_redu = class_3(1:50,:);
class_4_redu = class_4(1:50,:);

% Size of the full feature of interest matrix for each song in the working
% table.
[r1 c1] = size(foi);

% Label names for the axis
label_names = {'Rank', 'Danceability (nu)', 'Duration (ms)', ...
    'Liveliness (nu)', 'Tempo (bpm)'};

% Generate the plots for each of the features compared to each other.
for y = 1:c1
    for x = 1:y
        subplot(5, 5, 5 * (y - 1) + x);
        scatter(class_1_redu(:,x), class_1_redu(:,y), 'r', '*');
        hold on
        scatter(class_2_redu(:,x), class_2_redu(:,y), 'b', '.');
        hold on
        scatter(class_3_redu(:,x), class_3_redu(:,y), 'g', '+');
        hold on
        scatter(class_4_redu(:,x), class_4_redu(:,y), 'k', 'x');
        xlabel(label_names{x});
        ylabel(label_names{y});
        hold off
    end
end

legend('Rank 1 - 25','Rank 25 - 50','Rank 50 - 75','Rank 75 - 100');

% Remove the ranking from the class subsets.
class_1 = class_1(:,2:end);
class_2 = class_2(:,2:end);
class_3 = class_3(:,2:end);
class_4 = class_4(:,2:end);

format long

% Calculate the mean for each feature in the 4 classes ()
class_1_means = mean(class_1)
class_2_means = mean(class_2)
class_3_means = mean(class_3)
class_4_means = mean(class_4)

class_1_stds = std(class_1)
class_2_stds = std(class_2)
class_3_stds = std(class_3)
class_4_stds = std(class_4)




