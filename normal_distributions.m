% Iteration 2 Graphs

filename = 'working_table.csv';
data = readtable(filename);

adl = data{:,{'mean_acousticness','mean_danceability','mean_liveness'}};

% Class 1 = <=25
% Class 2 = >25 and <=50
% Class 3 = >50 and <=75
% Class 4 = >75

[rows,cols] = size(data);

class1 = table;
class2 = table;
class3 = table;
class4 = table;

for i=1:rows
    if data{i,11} <= 25
        class1 = [class1; data(i,:)];
    elseif data{i,11} > 25 && data{i,11} <= 50
        class2 = [class2; data(i,:)];
    elseif data{i,11} > 50 && data{i,11} <= 75
        class3 = [class3; data(i,:)];
    else
        class4 = [class4; data(i,:)];
    end
end
    
%% Plot normal distributions of features: Acousticness, Danceability, Liveness
% Calculate the mean and standard deviation of the feature
% Calculate the linear space and normal probability density function
muacoustic = mean(adl(:,1));
stdacoustic = std(adl(:,1));
x1 = linspace(muacoustic - (3 * stdacoustic), muacoustic + (3 * stdacoustic) , 100); 
y1 = normpdf(x1, muacoustic, stdacoustic);

mudance = mean(adl(:,2));
stddance = std(adl(:,2));
x2 = linspace(mudance - (3 * stddance), mudance + (3 * stddance) , 100); 
y2 = normpdf(x2, mudance, stddance);

mulive = mean(adl(:,3));
stdlive = std(adl(:,3));
x3 = linspace(mulive - (3 * stdlive), mulive + (3 * stdlive) , 100); 
y3 = normpdf(x3, mulive, stdlive);

% Plot the graph with labels
figure(1)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
title('Normal Distributions of Album Features')
xlabel('Scale')
ylabel('Density')
legend('Acousticness','Danceability','Liveness')
hold off


%% Plot normal distributions of Acousticness
muacoustic = mean(class1{:,3});
stdacoustic = std(class1{:,3});
x1 = linspace(muacoustic - (3 * stdacoustic), muacoustic + (3 * stdacoustic) , 100); 
y1 = normpdf(x1, muacoustic, stdacoustic);

muacoustic = mean(class2{:,3});
stdacoustic = std(class2{:,3});
x2 = linspace(muacoustic - (3 * stdacoustic), muacoustic + (3 * stdacoustic) , 100); 
y2 = normpdf(x2, muacoustic, stdacoustic);

muacoustic = mean(class3{:,3});
stdacoustic = std(class3{:,3});
x3 = linspace(muacoustic - (3 * stdacoustic), muacoustic + (3 * stdacoustic) , 100); 
y3 = normpdf(x3, muacoustic, stdacoustic);

muacoustic = mean(class4{:,3});
stdacoustic = std(class4{:,3});
x4 = linspace(muacoustic - (3 * stdacoustic), muacoustic + (3 * stdacoustic) , 100); 
y4 = normpdf(x4, muacoustic, stdacoustic);

figure(1)
subplot(2,2,1)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
plot(x4, y4, 'k')
title('Normal Distributions of Acousticness')
xlabel('Scale')
ylabel('Density')
legend('Class 1','Class 2','Class 3','Class 4')
hold off


%% Plot normal distributions of Danceability
mudance = mean(class1{:,4});
stddance = std(class1{:,4});
x1 = linspace(mudance - (3 * stddance), mudance + (3 * stddance) , 100); 
y1 = normpdf(x1, mudance, stddance);

mudance = mean(class2{:,4});
stddance = std(class2{:,4});
x2 = linspace(mudance - (3 * stddance), mudance + (3 * stddance) , 100); 
y2 = normpdf(x2, mudance, stddance);

mudance = mean(class3{:,4});
stddance = std(class3{:,4});
x3 = linspace(mudance - (3 * stddance), mudance + (3 * stddance) , 100); 
y3 = normpdf(x3, mudance, stddance);

mudance = mean(class4{:,4});
stddance = std(class4{:,4});
x4 = linspace(mudance - (3 * stddance), mudance + (3 * stddance) , 100); 
y4 = normpdf(x4, mudance, stddance);

subplot(2,2,3)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
plot(x4, y4, 'k')
title('Normal Distributions of Danceability')
xlabel('Scale')
ylabel('Density')
hold off


%% Plot normal distributions of Liveness
mulive = mean(class1{:,6});
stdlive = std(class1{:,6});
x1 = linspace(mulive - (3 * stdlive), mulive + (3 * stdlive) , 100); 
y1 = normpdf(x1, mulive, stdlive);

mulive = mean(class2{:,6});
stdlive = std(class2{:,6});
x2 = linspace(mulive - (3 * stdlive), mulive + (3 * stdlive) , 100); 
y2 = normpdf(x2, mulive, stdlive);

mulive = mean(class3{:,6});
stdlive = std(class3{:,6});
x3 = linspace(mulive - (3 * stdlive), mulive + (3 * stdlive) , 100); 
y3 = normpdf(x3, mulive, stdlive);

mulive = mean(class4{:,6});
stdlive = std(class4{:,6});
x4 = linspace(mulive - (3 * stdlive), mulive + (3 * stdlive) , 100); 
y4 = normpdf(x4, mulive, stdlive);

subplot(2,2,4)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
plot(x4, y4, 'k')
title('Normal Distributions of Liveness')
xlabel('Scale')
ylabel('Density')
hold off



%% Plot normal distributions of Duration
muduration = mean(class1{:,5});
stdduration = std(class1{:,5});
x1 = linspace(muduration - (3 * stdduration), muduration + (3 * stdduration) , 100); 
y1 = normpdf(x1, muduration, stdduration);

muduration = mean(class2{:,5});
stdduration = std(class2{:,5});
x2 = linspace(muduration - (3 * stdduration), muduration + (3 * stdduration) , 100); 
y2 = normpdf(x2, muduration, stdduration);

muduration = mean(class3{:,5});
stdduration = std(class3{:,5});
x3 = linspace(muduration - (3 * stdduration), muduration + (3 * stdduration) , 100); 
y3 = normpdf(x3, muduration, stdduration);

muduration = mean(class4{:,5});
stdduration = std(class4{:,5});
x4 = linspace(muduration - (3 * stdduration), muduration + (3 * stdduration) , 100); 
y4 = normpdf(x4, muduration, stdduration);

figure(2)
subplot(2,2,1)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
plot(x4, y4, 'k')
title('Normal Distributions of Duration')
xlabel('Scale')
ylabel('Density')
legend('Class 1','Class 2','Class 3','Class 4')
hold off


%% Plot normal distributions of Loudness
muloud = mean(class1{:,7});
stdloud = std(class1{:,7});
x1 = linspace(muloud - (3 * stdloud), muloud + (3 * stdloud) , 100); 
y1 = normpdf(x1, muloud, stdloud);

muloud = mean(class2{:,7});
stdloud = std(class2{:,7});
x2 = linspace(muloud - (3 * stdloud), muloud + (3 * stdloud) , 100); 
y2 = normpdf(x2, muloud, stdloud);

muloud = mean(class3{:,7});
stdloud = std(class3{:,7});
x3 = linspace(muloud - (3 * stdloud), muloud + (3 * stdloud) , 100); 
y3 = normpdf(x3, muloud, stdloud);

muloud = mean(class4{:,7});
stdloud = std(class4{:,7});
x4 = linspace(muloud - (3 * stdloud), muloud + (3 * stdloud) , 100); 
y4 = normpdf(x4, muloud, stdloud);

subplot(2,2,3)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
plot(x4, y4, 'k')
title('Normal Distributions of Loudness')
xlabel('Scale')
ylabel('Density')
hold off

%% Plot normal distributions of Tempo
mutemp = mean(class1{:,8});
stdtemp = std(class1{:,8});
x1 = linspace(mutemp - (3 * stdtemp), mutemp + (3 * stdtemp) , 100); 
y1 = normpdf(x1, mutemp, stdtemp);

mutemp = mean(class2{:,8});
stdtemp = std(class2{:,8});
x2 = linspace(mutemp - (3 * stdtemp), mutemp + (3 * stdtemp) , 100); 
y2 = normpdf(x2, mutemp, stdtemp);

mutemp = mean(class3{:,8});
stdtemp = std(class3{:,8});
x3 = linspace(mutemp - (3 * stdtemp), mutemp + (3 * stdtemp) , 100); 
y3 = normpdf(x3, mutemp, stdtemp);

mutemp = mean(class4{:,8});
stdtemp = std(class4{:,8});
x4 = linspace(mutemp - (3 * stdtemp), mutemp + (3 * stdtemp) , 100); 
y4 = normpdf(x4, mutemp, stdtemp);

subplot(2,2,4)
hold on
plot(x1, y1, 'r')
plot(x2, y2, 'b')
plot(x3, y3, 'g')
plot(x4, y4, 'k')
title('Normal Distributions of Tempo')
xlabel('Scale')
ylabel('Density')
hold off


