function [route, routeDist, W, numDistQual] = findShortest(cities, eta, epochs, C)

[numNodes, numAttr] = size(cities);

% Initialize randomized weight matrix (random weights between 0 and 1)
W = rand(numNodes,numAttr);

% Define neighbourhood size vector
neighSize = floor(linspace(2, 0, epochs)+0.2);
%randomCity = randperm(numNodes,numNodes);
numUpdates = zeros(1,numNodes);

for i = 1:epochs
    randCity = randperm(numNodes);
    for j = 1:numNodes
        % Calculate the distance between the weights and the attributes of
        % the current city
        p = cities(randCity(j),:);
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
        end
    end
end

route = zeros(numNodes,1);
numDistQual = 0;
for i = 1:numNodes
    p = cities(i,:);
    temp = p-W;
    d = sum(temp.^2,2);
    [~, dInd] = sort(d);
    j = 1;
    while ismember(dInd(j),route)
        j = j+1;
    end
    numDistQual = numDistQual+(j>1);
    route(i) = dInd(j);
    %[~,pos(i)] = min(d);
end

%posPrint = sprintf('%d ', pos);
%fprintf('Order: %s\n', posPrint);

routeDist = 0;
for i = 2:numNodes
    routeDist = routeDist + pdist([cities(route(i-1),:); cities(route(i),:)]);
end
%fprintf('The length of the road is: %.4f\n', routeDist)