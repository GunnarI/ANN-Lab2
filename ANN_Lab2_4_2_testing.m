clear all, close all, clc
cities = importCities('cities.dat');

% Define the step size
%eta = 0.2;

% Define number of epochs
%epochs = 100;

% Define the parameter for conscience to allow looser to win
%C = 1;
%[route, routeDist, bestW, ~] = findShortest(cities,0.4,100,0.5);

route = zeros(1:10);
routeDist = inf;
numDistQual = inf;
for epoch = 60:10:180
    for eta = 0.05:0.01:0.5
        for C = 0:0.5:5
            [tempRoute, tempRouteDist, W, tempNumDistQual] = ...
                findShortest(cities, eta, epoch, C);
            if tempRouteDist < routeDist && tempNumDistQual < numDistQual
                routeDist = tempRouteDist;
                route = tempRoute;
                numDistQual = tempNumDistQual;
                bestEta = eta;
                bestC = C;
                bestEpoch = epoch;
                bestW = W;
            end
        end
    end
end

figure
plot(bestW(:,1),bestW(:,2),'rd')
hold on
plot(cities(route,1),cities(route,2),'b--')
hold on
scatter(cities(:,1),cities(:,2),'g*');
legendNames = cellstr(num2str((1:length(route))'));
dx = 0.01; dy = 0.01;
text(cities(:,1)+dx, cities(:,2)+dy, legendNames);
legend('Weights','Route','Cities')
best_text = sprintf('eta = %.2f, Epoch = %d, C = %.2f',bestEta, bestEpoch, bestC);
title({'Shortest Route between Cities',best_text})
