clc; clear all;
names = import_mpnames('mpnames.txt');
numVoters = length(names);

votes = importVotes('votes.dat');
numVotes = 31;
votes = reshape(votes, numVotes, numVoters)';

% Coding: 0=no party, 1='m', 2='fp', 3='s', 4='v', 5='mp', 6='kd', 7='c'
mpparty = import_mpparty('mpparty.dat');
mpparty_str = strings(numVoters,1);
cmap = colormap(parula(8));
for i = 1:numVoters
    switch mpparty(i)
        case 0
            mpparty_str(i) = 'nop';
        case 1
            mpparty_str(i) = 'm';
        case 2
            mpparty_str(i) = 'fp';
        case 3
            mpparty_str(i) = 's';
        case 4
            mpparty_str(i) = 'v';
        case 5
            mpparty_str(i) = 'mp';
        case 6
            mpparty_str(i) = 'kd';
        case 7
            mpparty_str(i) = 'c';
    end
end

mpsex = import_mpsex('mpsex.dat');
mpdistrict = import_mpdistrict('mpdistrict.dat');
W = rand(100,numVotes);
W_ref = reshape(1:100,10,10);
% for n = 2:numVotes
%     W(:,:,n) = rand(10,10);
% end
eta = 0.2;
epochs = 50;
neighSize = floor(linspace(2, 0, epochs)+0.2);

for i = 1:epochs
    for j = 1:numVoters
        v = votes(j,:);
        temp = v-W;
        d = sum(temp.^2,2);
        [~,minNode] = min(d);

        indToUpdate = getMappedInd(minNode, neighSize(i));
        W(indToUpdate,:) = W(indToUpdate,:) + eta*(v-W(indToUpdate,:));
    end
end

posVoter = zeros(numVoters, 2);
for i = 1:numVoters
    v = votes(i,:);
    temp = v-W;
    d = sum(temp.^2,2);
    [~,minNode] = min(d);

    posVoter(i,1) = ceil(minNode/10);
    posVoter(i,2) = mod(minNode,10);
end

% Plot the results
%xpos = 1:numAnimals;
scatter(posVoter(:,1),posVoter(:,2));
legendParties = cellstr(mpparty_str);
dx = 0.1; dy = 0.1;
text(posVoter(:,1)+dx, posVoter(:,2)+dy, legendParties);
set(gca,'xtick',[])
title('Animal similarity positioning')
ylabel('Animal Position')