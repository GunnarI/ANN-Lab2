function [train_error, test_f] = ...
    delta_rbf_3_3(train, test, rbf, test_rbf, eta, epochs, mui, sigma, plotting)

%%% uses delta function with incremental learning algorithm.

%mui is the middle of the RBF, we place it at the sinusfunction.
%train_mui = get_mui(train_vect,train_sin,units);
%test_mui = get_mui(test_vect,test_sin,units);

%train is the data we are using
%train = [train_vect; train_sin];
%test = [test_vect; test_sin];

%Initialise weights
W = zeros(1,size(rbf,2));
test_f = zeros(1,length(train));

train_error = zeros(1,epochs);

for epoch = 1:epochs
    %Shuffle the data by random for each epoch
    shuffle = randperm(length(train));
    train = train(:,shuffle);
    test = test(:,shuffle);
    
    rbf = GaussianRBF3_3(train, mui, sigma);%rbf(:,shuffle);
    rbf = rbf';
    %test_rbf = test_rbf(shuffle,:);
    
    %create a phi matrix
    %rbf = GaussianRBF(train, train_mui, sigma);
    %rbf = rbf';
    
    %update weights for each datapoint
    for i = 1:length(train)
    
        %instantanious error xi(estimated error)
        e = train(2,i) - W*rbf(:,i);
        %xi(iter) = 0.5.*e.^2;                  %is built in delta_weight function
        
        %weight update
        deltaW = eta*e*rbf(:,i)';
        %deltaW2 = eta*e(2)*rbf(:,i)';
        W = W + deltaW;
        %W(2,:) = W(2,:) + deltaW2;
%         delta_weights = eta .* e * rbf(i,:);       %delta rule
%         weights = weights + delta_weights;
        
    end
    test_rbf = GaussianRBF3_3(test, mui, sigma);
    test_f = W*test_rbf';
    train_plot = W*rbf;
    %test the data in each epoch
    %test_rbf = GaussianRBF(test, test_mui ,sigma);
    %test_rbf = test_rbf';
    %test_f(i) = weights*test_rbf(:,i);
    %deshuffle functions and data
    rbf(:,shuffle) = rbf;
    train(:,shuffle) = train;
    test(:,shuffle) = test;
    test_f(:,shuffle) = test_f;
    train_plot(:,shuffle) = train_plot;
    
    %Calculate error
    %train_error(epoch) = mean(abs(train_sin - weights*rbf));
    train_error(epoch) = mean((W*rbf - train(2,:)).^2);
end

%train_plot = W*rbf;
figure
plot(train(1,:),train_plot)
title('Guns')

if plotting
    %plotting of training and testing function with output
    figure(1)
    str = sprintf('Epoch: %d, Hidden Nodes %d', epoch, units);
    %plot training function
    subplot(2,1,1)
    plot(train_sin), hold on
    plot(weights*rbf), hold off
    title({'Training function';str}),
    legend('original','output')
    
    %plot testing function
    subplot(2,1,2)
    plot(test_sin), hold on
    plot(test_f), hold off
    title({'Testing function';str})
    legend('original','output')
    
end

%error of as mean of all N patterns
%train_error = mean(train_error);
%train_error = train_error(end);
