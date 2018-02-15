clc; clear all;
[props, animalNames, animalAttributes] = LoadAnimalData();
numAnimals = length(animalNames);
numAttr = length(animalAttributes);
numNodes = 100;

% Initialize randomized weight matrix (random weights between 0 and 1)
W = rand(numNodes,numAttr);

% Step size is 0.2 as given in instructions
eta = 0.2;

% Define number of epochs
epochs = 20;
% Define neighbourhood size vector
neighSize = round(linspace(50, 1, epochs));
for i = 1:epochs
    for j = 1:numAnimals
        % Calculate the distance between the weights and the attributes of
        % the current animal
        p = props(j,:);
        temp = p-W;
        d = sum(temp.^2,2);
        [~,minNode] = min(d);
        
        % Update the weights which correspond to the shortest distance as
        % well as all its neighbouring weights
        for k = max(1,minNode-neighSize(i)):min(numNodes,minNode+neighSize(i))
            W(k,:) = W(k,:) + eta*(p-W(k,:));
        end
    end
end

% Find the positions (from 1 to 100) for each of the animals
pos = zeros(numAnimals,1);
for i = 1:numAnimals
    p = props(i,:);
    temp = p-W;
    d = sum(temp.^2,2);
    [~,pos(i)] = min(d);
end

% Plot the results
xpos = 1:numAnimals;
scatter(xpos,pos);
legendNames = cellstr(animalNames);
dx = 0.1; dy = 0.1;
text(xpos+dx, pos+dy, legendNames);
set(gca,'xtick',[])
title('Animal similarity positioning')
ylabel('Animal Position')