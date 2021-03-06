%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/beedak/Documents/MATLAB/css490/FinalProject/working_table.csv
%
% Auto-generated by MATLAB on 04-Jun-2019 18:54:33

%% Setup the Import Options
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
workingtable = readtable("/working_table.csv", opts);


%% Clear temporary variables
clear opts