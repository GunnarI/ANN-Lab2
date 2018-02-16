close all;
cities = importCities('cities.dat');

[numNodes, numAttr] = size(cities);

% Initialize randomized weight matrix (random weights between 0 and 1)
W = rand(numNodes,numAttr);

% Define the step size
eta = 0.5;

% Define number of epochs
epochs = 30;
% Define neighbourhood size vector
neighSize = floor(linspace(2, 0, epochs));
%randomCity = randperm(numNodes,numNodes);
numUpdates = zeros(1,numNodes);

% Defining parameters for plot animation
cmap = colormap(parula(10));
h1 = animatedline('Marker','d','Color',cmap(1,:)); 
h2 = animatedline('Marker','d','Color',cmap(2,:)); 
h3 = animatedline('Marker','d','Color',cmap(3,:)); 
h4 = animatedline('Marker','d','Color',cmap(4,:));
h5 = animatedline('Marker','d','Color',cmap(5,:)); 
h6 = animatedline('Marker','d','Color',cmap(6,:)); 
h7 = animatedline('Marker','d','Color',cmap(7,:)); 
h8 = animatedline('Marker','d','Color',cmap(8,:));
h9 = animatedline('Marker','d','Color',cmap(9,:)); 
h10 = animatedline('Marker','d','Color',cmap(10,:));
h = {h1, h2, h3, h4, h5, h6, h7, h8, h9, h10};
for w_index = 1:10
    addpoints(h{w_index},W(w_index,1),W(w_index,2));
end
drawnow;
hold on

scatter(cities(:,1),cities(:,2),'g*');
hold on

% Define the parameter for conscience to allow looser to win
C = 1;
for i = 1:epochs
    for j = 1:numNodes
        % Calculate the distance between the weights and the attributes of
        % the current city
        p = cities(j,:);
        temp = p-W;
        % Introducing bias depending on the number of times a weight vector
        % has been updated so that if it has not been updated often it
        % might get picked as a winner even though it isn't
        bias = C*(1/numNodes - numUpdates./sum(numUpdates));
        d = sum(temp.^2,2)-bias';
        [~,minNode] = min(d);
        %fprintf('Winning node: %d\n', minNode)
        
        % Update the weights which correspond to the shortest distance as
        % well as all its neighbouring weights
        for k = minNode-neighSize(i):minNode+neighSize(i)
            if k < 1
                l = numNodes + k;
            elseif k > numNodes
                l = k - numNodes;
            else
                l = k;
            end
                
            W(l,:) = W(l,:) + eta*(p-W(l,:));
            numUpdates(l) = numUpdates(l)+1;
            
            clearpoints(h{l});
            addpoints(h{l},W(l,1),W(l,2));
            drawnow;
            pause(0.01);
        end
    end
end
hold off

pos = zeros(numNodes,1);
for i = 1:numNodes
    p = cities(i,:);
    temp = p-W;
    d = sum(temp.^2,2);
    [~,pos(i)] = min(d);
end

posPrint = sprintf('%d ', pos);
fprintf('Order: %s\n', posPrint);

roadLength = 0;
for i = 2:numNodes
    roadLength = roadLength + pdist([cities(pos(i-1),:); cities(pos(i),:)]);
end
fprintf('The length of the road is: %.4f\n', roadLength)

figure
plot(W(:,1),W(:,2),'r+')
hold on
plot(cities(pos,1),cities(pos,2),'b--')
hold on
scatter(cities(:,1),cities(:,2),'g*');
legendNames = cellstr(num2str((1:numNodes)'));
dx = 0.01; dy = 0.01;
text(cities(:,1)+dx, cities(:,2)+dy, legendNames);