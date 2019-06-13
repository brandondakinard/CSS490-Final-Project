% Import the data
tbl = readtable("working_table_updated.csv");

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
index_class_1_foi_with_date = find(foi_with_date(:,1) > 1959 & foi_with_date(:,1) <= 1969);
index_class_2_foi_with_date = find(foi_with_date(:,1) > 1969 & foi_with_date(:,1) <= 1979);
index_class_3_foi_with_date = find(foi_with_date(:,1) > 1979 & foi_with_date(:,1) <= 1989);
index_class_4_foi_with_date = find(foi_with_date(:,1) > 1989 & foi_with_date(:,1) <= 1999);
index_class_5_foi_with_date = find(foi_with_date(:,1) > 1999 & foi_with_date(:,1) <= 2009);
index_class_6_foi_with_date = find(foi_with_date(:,1) > 2009 & foi_with_date(:,1) <= 2019);

class_1_foi_with_date = foi_with_date(index_class_1_foi_with_date(1,1):index_class_2_foi_with_date(1,1) - 1,:);
class_2_foi_with_date = foi_with_date(index_class_2_foi_with_date(1,1):index_class_3_foi_with_date(1,1) - 1,:);
class_3_foi_with_date = foi_with_date(index_class_3_foi_with_date(1,1):index_class_4_foi_with_date(1,1) - 1,:);
class_4_foi_with_date = foi_with_date(index_class_4_foi_with_date(1,1):index_class_5_foi_with_date(1,1) - 1,:);
class_5_foi_with_date = foi_with_date(index_class_5_foi_with_date(1,1):index_class_6_foi_with_date(1,1) - 1,:);
class_6_foi_with_date = foi_with_date(index_class_6_foi_with_date(1,1):end,:);


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
index_class_1_ur = find(Ur(:,1) > 1959 & Ur(:,1) <= 1969);
index_class_2_ur = find(Ur(:,1) > 1969 & Ur(:,1) <= 1979);
index_class_3_ur = find(Ur(:,1) > 1979 & Ur(:,1) <= 1989);
index_class_4_ur = find(Ur(:,1) > 1989 & Ur(:,1) <= 1999);
index_class_5_ur = find(Ur(:,1) > 1999 & Ur(:,1) <= 2009);
index_class_6_ur = find(Ur(:,1) > 2009 & Ur(:,1) <= 2019);

class_1_ur = Ur(index_class_1_ur(1,1):index_class_2_ur(1,1) - 1,:);
class_2_ur = Ur(index_class_2_ur(1,1):index_class_3_ur(1,1) - 1,:);
class_3_ur = Ur(index_class_3_ur(1,1):index_class_4_ur(1,1) - 1,:);
class_4_ur = Ur(index_class_4_ur(1,1):index_class_5_ur(1,1) - 1,:);
class_5_ur = Ur(index_class_5_ur(1,1):index_class_6_ur(1,1) - 1,:);
class_6_ur = Ur(index_class_6_ur(1,1):end,:);

% Reduce the size of the classes to be consistent across all 4 with
% % respects to the smallest class
% [r1, c1] = size(class_1);
% class_1_ur = class_1_ur(1:r1,2:end);
% class_2_ur = class_2_ur(1:r1,2:end);
% class_3_ur = class_3_ur(1:r1,2:end);
% class_4_ur = class_4_ur(1:r1,2:end);
% 
% Ur = Ur(:,2:end);
