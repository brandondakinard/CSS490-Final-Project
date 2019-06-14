% Import the data
tbl = readtable("working_table_updated.csv");


%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = "<SEP>";

% Specify column names and types
opts.VariableNames = ["id", "longitude", "latitude", "artist", "city"];
opts.VariableTypes = ["string", "double", "double", "string", "string"];
opts = setvaropts(opts, [1, 4, 5], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 4, 5], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
subsetartistlocation = readtable("/subset_artist_location.csv", opts);


%% Clear temporary variables
clear opts;

% Extracting columns containing our features of interest into individual
% columns for analysis
acousticness = table2array(tbl(:,3));
danceability = table2array(tbl(:,4));
liveliness = table2array(tbl(:,6));
duration = table2array(tbl(:,5));
tempo = table2array(tbl(:,7));
date = table2array(tbl(:,15));

% Column in order of rank danceability duration liveliness tempo as
% indicated below
foi = [acousticness danceability liveliness duration tempo];
foi_with_date = [date acousticness danceability liveliness duration tempo];

[rows,cols] = size(tbl);

% Order features by date
foi_with_date = sortrows(foi_with_date, 1);

% Find the index in which the different classes occur in the unsplit matrix
% containing all song dates.
index_class_1 = find(foi_with_date(:,1) > 1959 & foi_with_date(:,1) <= 1979);
index_class_2 = find(foi_with_date(:,1) > 1979 & foi_with_date(:,1) <= 1999);
index_class_3 = find(foi_with_date(:,1) > 1999 & foi_with_date(:,1) <= 2019);

class_1_orig = foi_with_date(index_class_1(1,1):index_class_2(1,1) - 1,:);
class_2_orig = foi_with_date(index_class_2(1,1):index_class_3(1,1) - 1,:);
class_3_orig = foi_with_date(index_class_3(1,1):end,:);


%% Preprocessing the Data

% Calculate the relevant statistics within the numerical values in the
% datasets
means = mean(foi);
stdvs = std(foi);
covs = cov(foi);

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

Ur = [date Ur];

% Order Ur by date
Ur = sortrows(Ur, 1);

% Find the index in which the different classes occur in the unsplit matrix
% containing all song dates.
index_class_1_ur = find(Ur(:,1) > 1959 & Ur(:,1) <= 1979);
index_class_2_ur = find(Ur(:,1) > 1979 & Ur(:,1) <= 1999);
index_class_3_ur = find(Ur(:,1) > 1999 & Ur(:,1) <= 2019);

class_1_ur = Ur(index_class_1_ur(1,1):index_class_2_ur(1,1) - 1,:);
class_2_ur = Ur(index_class_2_ur(1,1):index_class_3_ur(1,1) - 1,:);
class_3_ur = Ur(index_class_3_ur(1,1):end,:);

%% Select random sample for original data by class
sample_size = 500;

% Class 1
%get the dimensions of your array   
[s1, f1] = size(class_1_orig); 
% add another column with a random number 
for i=1:s1 
    class_1_orig(i,f1+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_1_orig_s1=sortrows(class_1_orig,f1+1); 
class_1_old = [class_1_orig_s1(1:sample_size,1:f1)];

% Class 2
%get the dimensions of your array   
[s2, f2] = size(class_2_orig); 
% add another column with a random number 
for i=1:s2 
    class_2_orig(i,f2+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_2_orig_s2=sortrows(class_2_orig,f2+1); 
class_2_old = [class_2_orig_s2(1:sample_size,1:f2)];

% Class 3
%get the dimensions of your array   
[s3, f3] = size(class_3_orig); 
% add another column with a random number 
for i=1:s3 
    class_3_orig(i,f3+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_3_orig_s3=sortrows(class_3_orig,f3+1); 
class_3_old = [class_3_orig_s3(1:sample_size,1:f3)];


%% Select random sample for transformed data by class

% Class 1
%get the dimensions of your array   
[s1, f1] = size(class_1_ur); 
% add another column with a random number 
for i=1:s1 
    class_1_ur(i,f1+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_1_ur_s1=sortrows(class_1_ur,f1+1); 
class_1_new = [class_1_ur_s1(1:sample_size,1:f1)];

% Class 2
%get the dimensions of your array   
[s2, f2] = size(class_2_ur); 
% add another column with a random number 
for i=1:s2 
    class_2_ur(i,f2+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_2_ur_s2=sortrows(class_2_ur,f2+1); 
class_2_new = [class_2_ur_s2(1:sample_size,1:f2)];

% Class 3
%get the dimensions of your array   
[s3, f3] = size(class_3_ur); 
% add another column with a random number 
for i=1:s3 
    class_3_ur(i,f3+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_3_ur_s3=sortrows(class_3_ur,f3+1); 
class_3_new = [class_3_ur_s3(1:sample_size,1:f3)];



%% 2D Scatter Plots of Features
% Transformed dataset
[r1, c1] = size(class_1_new); 

label_names = {'Acousticness (nu)', 'Danceability (nu)', ...
    'Liveness (nu)', 'Duration (ms)', 'Tempo (bpm)'};

figure;
for y = 2:c1
    for x = 2:y - 1
        subplot(c1-2, c1-2, (c1-2) * (y - 3) + (x-1));
        scatter(class_1_new(:,x), class_1_new(:,y), 'r', '+');
        hold on;
        scatter(class_2_new(:,x), class_2_new(:,y), 'b', '*');
        hold on;
        scatter(class_3_new(:,x), class_3_new(:,y), 'g', '.');
        xlabel(label_names{x-1});
        ylabel(label_names{y-1});
        hold off;
    end
end
sgtitle('2D Scatter Plots of the Transformed Features in the Dataset');
legend('1960s - 1970s','1980s - 1990s','2000s - 2010s');

% Original dataset
[r2, c2] = size(class_1_old); 

label_names = {'Acousticness (nu)', 'Danceability (nu)', ...
    'Liveness (nu)', 'Duration (ms)', 'Tempo (bpm)'};

figure;
for y = 2:c2
    for x = 2:y - 1
        subplot(c2-2, c2-2, (c2-2) * (y - 3) + (x-1));
        scatter(class_1_old(:,x), class_1_old(:,y), 'r', '+');
        hold on;
        scatter(class_2_old(:,x), class_2_old(:,y), 'b', '*');
        hold on;
        scatter(class_3_old(:,x), class_3_old(:,y), 'g', '.');
        xlabel(label_names{x-1});
        ylabel(label_names{y-1});
        hold off;
    end
end
sgtitle('2D Scatter Plots of the Original Features in the Dataset');
legend('1960s - 1970s','1980s - 1990s','2000s - 2010s');

%% SVM classifier
class_1_old_svm = [ones([size(class_1_old,1),1]) class_1_old];
class_2_old_svm = [(ones([size(class_2_old,1),1]) * 2) class_2_old];
X_dat = [class_1_old_svm; class_2_old_svm];
y = X_dat(1:size(X_dat,1),1);
SVMModel = fitcsvm(X_dat,y);

classOrder = SVMModel.ClassNames;

sv = SVMModel.SupportVectors;
figure
gscatter(X_dat(:,3),X_dat(:,4),y)
hold on
plot(sv(:,3),sv(:,4),'ko','MarkerSize',10)
hold off

% Assign principal components to the variables x,y,z
label_names_PC = ["PC0", "PC1", "PC2", "PC3", "PC4", "PC5"];

% Generate 3D Scatter Plots for class data after SVD
for x = 2:size(label_names_PC, 2)
    for y = x+1:size(label_names_PC, 2)
        for z = y+1:size(label_names_PC, 2)
            % 3D scatter plots using PC1, PC2, and PC3 from Ur
            figure; 
            scatter3(class_1_ur(:,x), class_1_ur(:,y), class_1_ur(:,z), 'r.'); 
            hold on; 
            scatter3(class_2_ur(:,x), class_2_ur(:,y), class_2_ur(:,z), 'b.');
            hold on;
            scatter3(class_3_ur(:,x), class_3_ur(:,y), class_3_ur(:,z), 'g.');
            xlabel(join(['PC', int2str(x - 1)]));
            ylabel(join(['PC', int2str(y - 1)]));
            zlabel(join(['PC', int2str(z - 1)]));
            title('3D Scatter Plot of Regular Scores from Ur after SVD')
            legend('1960s-1970s','1980s-1990s','2000s-2010s');
            hold off;
        end
    end
end
