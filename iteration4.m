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

%% Select random sample for transformed data by class
sample_size = 100;

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

% Class 4
%get the dimensions of your array   
[s4, f4] = size(class_4_ur); 
% add another column with a random number 
for i=1:s4 
    class_4_ur(i,f4+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_4_ur_s4=sortrows(class_4_ur,f4+1); 
class_4_new = [class_4_ur_s4(1:sample_size,1:f4)];

% Class 5
%get the dimensions of your array   
[s5, f5] = size(class_5_ur); 
% add another column with a random number 
for i=1:s5 
    class_5_ur(i,f5+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_5_ur_s5=sortrows(class_5_ur,f5+1); 
class_5_new = [class_5_ur_s5(1:sample_size,1:f5)];

% Class 6
%get the dimensions of your array   
[s6, f6] = size(class_6_ur); 
% add another column with a random number 
for i=1:s6 
    class_6_ur(i,f6+1)=rand; 
end 
% Randomize by sorting the matrix based on the new random column 
class_6_ur_s6=sortrows(class_6_ur,f6+1); 
class_6_new = [class_6_ur_s6(1:sample_size,1:f6)];

%% 2D Scatter Plots of Transformed Features
[r1, c1] = size(class_1_new); 

% Acoustic, dance
subplot(6,6,1)
hold on
scatter(class_1_new(:,2), class_1_new(:,3),'r', '.')
scatter(class_2_new(:,2), class_2_new(:,3),'b', '.')
scatter(class_3_new(:,2), class_3_new(:,3),'g', '.')
scatter(class_4_new(:,2), class_4_new(:,3),'k', '.')
scatter(class_5_new(:,2), class_5_new(:,3),'m', '.')
scatter(class_6_new(:,2), class_6_new(:,3),'c', '.')
title('Sepal Length vs. Sepal Width')
xlabel('Sepal Length (cms)')
ylabel('Sepal Width (cms)')
hold off

