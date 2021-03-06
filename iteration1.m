%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /albums.csv
%
% Auto-generated by MATLAB on 04-May-2019 22:52:46

%% Setup the Import Options for the albums table
opts = delimitedTextImportOptions("NumVariables", 7);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["id", "date", "artist", "album", "rank", "length", "track_length"];
opts.VariableTypes = ["double", "string", "string", "string", "double", "double", "double"];
opts = setvaropts(opts, [3, 4], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [3, 4], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
albums = readtable("/albums.csv", opts);

%% Setup the Import Options for the albums table
opts = delimitedTextImportOptions("NumVariables", 19);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["id", "song", "album", "artist", "acousticness", "danceability", "duration_ms", "energy", "instrumentalness", "key", "liveness", "loudness", "mode", "speechiness", "tempo", "time_signature", "valence", "album_id", "date"];
opts.VariableTypes = ["double", "string", "string", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string", "string"];
opts = setvaropts(opts, [3, 4], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [3, 4], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
acoustic_features = readtable("/acoustic_features.csv", opts);

%% Clear temporary variables
clear opts;

%% Calculate the means of the albums acoustic features and the albums rank
modified_acoustic_features = acoustic_features(:,{'album', 'artist', 'acousticness', 'danceability', 'duration_ms', 'liveness','tempo'});

means_acoustic_features = grpstats(modified_acoustic_features, {'album', 'artist'});

modified_albums = albums(:,{'album', 'artist', 'rank'});

means_albums = grpstats(modified_albums, {'album', 'artist'});

%% Join the two matrices and filter out the albums which are missing album titles
preprocessed_data = outerjoin(means_acoustic_features, means_albums, 'Keys', {'album', 'artist'});

pruned_data = rmmissing(preprocessed_data);

% Filter for tables with size < 500
sorted_final_table = sortrows(pruned_data, 'mean_rank');
% Produces a table with data on 500 albums
working_table = sorted_final_table(:,:);
working_table = [working_table(:,1:2) working_table(:, 4:end)];

%% Add date to element entries
preprocessed_albums = rmmissing(means_albums);
sorted_preprocessed_albums = sortrows(preprocessed_albums, 'artist');

working_table.Properties.VariableNames = {'album', 'artist', ...
    'Acousticness', 'Danceability', 'Duration', 'Liveness', 'Tempo', ...
    'AlbumDu', 'ArtistDu', 'GroupCount', 'Rank'};


%% Save final table for future use
writetable(working_table,'working_table.csv','Delimiter',',');
type 'working_table.csv';