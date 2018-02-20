function [train_error, test_f] = delta_rbf(train_vect, train_sin, test_vect, test_sin, sigma, eta, epochs, units, plotting)
%%% uses delta function with incremental learning algorithm.

%mui is the middle of the RBF, we place it at the sinusfunction.
train_mui = get_mui(train_vect,train_sin,units);
test_mui = get_mui(test_vect,test_sin,units);

%train is the data we are using
train = [train_vect; train_sin];
test = [test_vect; test_sin];

%Initialise weights
weights = zeros(1,units);

for epoch = 1:epochs
    %Shuffle the data by random for each epoch
    shuffle = randperm(length(train));
    train = train(:,shuffle);
    test = test(:,shuffle);
    
    %create a phi matrix
    rbf = GaussianRBF(train, train_mui, sigma);
    rbf = rbf';
    
    %update weights for each datapoint
    for i = 1:length(train)
    
        %instantanious error xi(estimated error)
        e = train(2,i) - weights*rbf(:,i);
        %xi(iter) = 0.5.*e.^2;                  %is built in delta_weight function
        
        %weight update
        delta_weights = eta .* e * rbf(:,i)';       %delta rule
        weights = weights + delta_weights;
        
        %test the data in each epoch
        test_rbf = GaussianRBF(test, test_mui ,sigma);
        test_rbf = test_rbf';
        test_f(i) = weights*test_rbf(:,i);
    end
    
    %deshuffle functions and data
    rbf(:,shuffle) = rbf;
    train(:,shuffle) = train;
    test(:,shuffle) = test;
    test_f(:,shuffle) = test_f;
    
    %Calculate error
    %train_error(epoch) = mean(abs(train_sin - weights*rbf));
    train_error(epoch) = mean((weights*rbf - train_sin).^2);
end

if plotting == true
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
