%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/beedak/Documents/MATLAB/css490/homework3/wine_beer_dataset.csv
%
% Auto-generated by MATLAB on 22-May-2019 20:34:52

%% Import working table for project
% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 11);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["album_means_acoustic_features", "artist_means_acoustic_features", "mean_acousticness", "mean_danceability", "mean_duration_ms", "mean_liveness", "mean_tempo", "album_means_albums", "artist_means_albums", "GroupCount_means_albums", "mean_rank"];
opts.VariableTypes = ["string", "string", "double", "double", "double", "double", "double", "string", "string", "double", "double"];
opts = setvaropts(opts, [1, 2, 8, 9], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2, 8, 9], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
tbl = readtable("/working_table.csv", opts);

%% Clear temporary variables
clear opts;

% Extracting columns containing our features of interest into individual
% columns for analysis
rank = table2array(tbl(:,11));

acousticness = table2array(tbl(:,3));
danceability = table2array(tbl(:,4));
liveliness = table2array(tbl(:,6));
duration = table2array(tbl(:,5));
tempo = table2array(tbl(:,7));

% Column in order of rank danceability duration liveliness tempo as
% indicated below
foi = [rank acousticness danceability liveliness duration tempo];

% Find the index in which the different classes occur in the unsplit matrix
% containing all songs ranked 1 - 100.
index_class_1 = find(foi(:,1) > 25);
index_class_2 = find(foi(:,1) > 50);
index_class_3 = find(foi(:,1) > 75);

class_1 = foi(1:index_class_1(1,1) - 1,:);
class_2 = foi(index_class_1(1,1):index_class_2(1,1) - 1,:);
class_3 = foi(index_class_2(1,1):index_class_3(1,1) - 1,:);
class_4 = foi(index_class_3(1,1):end,:);

% Reduce the size of the classes to be consistent across all 4 with
% respects to the smallest class, class_1.
[r1, c1] = size(class_1);
class_1 = class_1(1:r1,2:c1);
class_2 = class_2(1:r1,2:c1);
class_3 = class_3(1:r1,2:c1);
class_4 = class_4(1:r1,2:c1);

ranks = foi(:,1);
foi = foi(:,2:end);

%% Create 2D scatter plots of the features within the data set
% Label names for the axis
label_names = {'Acousticness (nu)', 'Danceability (nu)', ...
    'Duration (ms)', 'Liveliness (nu)', 'Tempo (bpm)'};

% Calculate the relevant statistics within the numerical values in the
% datasets
means = mean(foi);
stdvs = std(foi);
covs = cov(foi);

[~, c1] = size(foi);

% Generate 2D scatter plots of each feature against itself and each of the
% other features
figure;
for y = 1:c1
    for x = 1:y
        subplot(c1,c1,c1 * (y - 1) + x);
        scatter(foi(:,x), foi(:,y), 'bo', 'filled');
        xlabel(label_names{x});
        ylabel(label_names{y});
    end
end

sgtitle('2D Scatter Plots of the Original Features in the Dataset');

% Generate the plots for each of the features compared to each other.
figure;
for y = 1:c1
    for x = 1:y
        subplot(5, 5, 5 * (y - 1) + x);
        scatter(class_1(:,x), class_1(:,y), 'r', '*');
        hold on;
        scatter(class_2(:,x), class_2(:,y), 'b', '.');
        hold on;
        scatter(class_3(:,x), class_3(:,y), 'g', '+');
        hold on;
        scatter(class_4(:,x), class_4(:,y), 'k', 'x');
        xlabel(label_names{x});
        ylabel(label_names{y});
        hold off;
    end
end

legend('Rank 1 - 25','Rank 25 - 50','Rank 50 - 75','Rank 75 - 100');
title_string = ['2D Scatter Plots of the Original Features in the' ...
    ' Dataset with Class Distinction'];
sgtitle(title_string);

%% Preprocessing the Data
% Define X_original, nfeatures, and nsamples
X_original = foi;
[nsamples, nfeatures] = size(X_original);

X = zeros(nsamples,nfeatures);
% Mean-center/scale each feature, X is NORMALIZED & MEAN CENTERED  dataset
for i=1:nfeatures
    for j=1:nsamples
        X(j,i) = (means(:,i) - X_original(j,i))/stdvs(:,i);
    end
end

%% Singular Value Decomposition Function
% X is the original dataset
% Ur will be the transformed dataset
% S is covariance matrix (not normalized)
[U, S, V] = svd(X,0);
Ur = U*S;

% Number of features to use
f_to_use = nfeatures;
feature_vector = 1:f_to_use;

r = Ur;

Ur = [ranks Ur];

% Find the index in which the different classes occur in the unsplit matrix
% containing all songs ranked 1 - 100.
index_class_1_ur = find(Ur(:,1) > 25);
index_class_2_ur = find(Ur(:,1) > 50);
index_class_3_ur = find(Ur(:,1) > 75);

class_1_ur = Ur(1:index_class_1_ur(1,1) - 1,:);
class_2_ur = Ur(index_class_1_ur(1,1):index_class_2_ur(1,1) - 1,:);
class_3_ur = Ur(index_class_2_ur(1,1):index_class_3_ur(1,1) - 1,:);
class_4_ur = Ur(index_class_3_ur(1,1):end,:);

% Reduce the size of the classes to be consistent across all 4 with
% respects to the smallest class
[r1, c1] = size(class_1);
class_1_ur = class_1_ur(1:r1,2:end);
class_2_ur = class_2_ur(1:r1,2:end);
class_3_ur = class_3_ur(1:r1,2:end);
class_4_ur = class_4_ur(1:r1,2:end);

Ur = Ur(:,2:end);

%% Scree Plots
% Obtain the necessary information for Scree Plots 
% Obtain S^2 (and can also use to normalize S)   
S2 = S^2; 
weights2 = zeros(nfeatures,1); 
weight_c2 = zeros(nfeatures);
sumS2 = sum(sum(S2)); 
weightsum2 = 0; 

for i=1:nfeatures 
    weights2(i) = S2(i,i)/sumS2; 
    weightsum2 = weightsum2 + weights2(i); 
    weight_c2(i) = weightsum2; 
end 

% Plotting Scree Plots
figure; 
subplot(1,2,1);
hold on;
plot(weights2,'x:b');
grid;
title('Scree Plot');
xlabel('Principal Component');
ylabel('Weight');
hold off;

subplot(1,2,2);
hold on;
plot(weight_c2,'x:r');
grid;
title('Scree Plot Cumulative');
xlabel('Principal Component');
ylabel('Weight');
hold off;
sgtitle('Scree Plots');

%% Loading Vectors
Vsquare = zeros(nfeatures,nfeatures);
for i=1:nfeatures
    for j=1:nfeatures
        Vsquare(i,j) = V(i,j)^2;
        if V(i,j)<0
            Vsquare(i,j) = Vsquare(i,j)*-1;
        else
            Vsquare(i,j) = Vsquare(i,j)*1;
        end
    end
end

figure;
for i=1:nfeatures
    subplot(3,2,i);
    hold on;
    bar(Vsquare(:,i),0.5); 
    grid; 
    ymin = min(Vsquare(:,i)) + (min(Vsquare(:,i))/10); 
    ymax = max(Vsquare(:,i)) + (max(Vsquare(:,i))/10); 
    axis([0 nfeatures+1 ymin ymax]); 
    xlabel('Feature index'); 
    ylabel('Importance of feature'); 
    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
    title(chart_title); 
    hold off;
end
sgtitle('Vector Loading Plots');

%% 2D scatter plots (transformed)
[r2, c2] = size(Ur);

label_names = {'PC1', 'PC2', 'PC3', 'PC4', 'PC5'};

% 2D scatter plots for the classes as dictated by Ur 
figure;
for y = 1:c2
    for x = 1:y 
        subplot(c2,c2,c2 * (y - 1) + x);
        scatter(Ur(:,x), Ur(:,y), 'bo', 'filled');
        xlabel(label_names{x});
        ylabel(label_names{y});
    end
end

sgtitle('2D Scatter Plots of the Principal Components');

%% 3D Scatter Plots
% Assign principal components to the variables x,y,z
label_names_PC = ["PC1", "PC2", "PC3", "PC4", "PC5"];

% Generate 3D Scatter Plots 
for x = 1:size(label_names_PC, 2)
    for y = x+1:size(label_names_PC, 2)
        for z = y+1:size(label_names_PC, 2)
            % 3D scatter plots using PC1, PC2, and PC3 from Ur
            figure; 
            scatter3(class_1(:,x), class_1(:,y), class_1(:,z), 'r.'); 
            hold on; 
            scatter3(class_2(:,x), class_2(:,y), class_2(:,z), 'b.');
            hold on;
            scatter3(class_3(:,x), class_3(:,y), class_3(:,z), 'g.');
            hold on;
            scatter3(class_4(:,x), class_4(:,y), class_4(:,z), 'k.');
            xlabel(x);
            ylabel(y);
            zlabel(z);
            title('3D Scatter Plot of Regular Scores')
            legend('Rank 1 - 25','Rank 25 - 50',...
                'Rank 50 - 75','Rank 75 - 100');
            hold off;
        end
    end
end

% Generate 3D Scatter Plots for class data after SVD
for x = 1:size(label_names_PC, 2)
    for y = x+1:size(label_names_PC, 2)
        for z = y+1:size(label_names_PC, 2)
            % 3D scatter plots using PC1, PC2, and PC3 from Ur
            figure; 
            scatter3(class_1_ur(:,x), class_1_ur(:,y), class_1_ur(:,z), 'r.'); 
            hold on; 
            scatter3(class_2_ur(:,x), class_2_ur(:,y), class_2_ur(:,z), 'b.');
            hold on;
            scatter3(class_3_ur(:,x), class_3_ur(:,y), class_3_ur(:,z), 'g.');
            hold on;
            scatter3(class_4_ur(:,x), class_4_ur(:,y), class_4_ur(:,z), 'k.');
            xlabel(x);
            ylabel(y);
            zlabel(z);
            title('3D Scatter Plot of Regular Scores after SVD')
            legend('Rank 1 - 25','Rank 25 - 50',...
                'Rank 50 - 75','Rank 75 - 100');
            hold off;
        end
    end
end

