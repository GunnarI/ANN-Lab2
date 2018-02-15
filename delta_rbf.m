function [train_error] = delta_rbf(train_vect, train_sin, test_vect, test_sin, sigma, eta, epochs, units, plotting)
%%% uses delta function with incremental learning algorithm

%mui is the middle of the RBF, we place it at the sinusfunction.
mui = get_mui(train_vect,train_sin,units);

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
    rbf = GaussianRBF(train, mui, sigma);
    rbf = rbf';
    
    %update weights for each datapoint
    for i = 1:length(test)
    
        %instantanious error xi(estimated error)
        e = train_sin(i) - weights*rbf(:,i);
        %xi(iter) = 0.5.*e.^2;                  %is built in delta_weight function
        
        %weight update
        delta_weights = eta .* e * rbf(:,i)';       %delta rule
        weights = weights + delta_weights;
        
        %test the data in each epoch
        test_mui = get_mui(test(1,:),test(2,:),units);
        test_rbf = GaussianRBF(test, test_mui ,sigma);
        test_rbf = test_rbf';
        test_f = weights*test_rbf;
    end
    train_error(epoch) = mean(abs(train_sin - weights*rbf));
end

%error of the last epoch for comparison
train_error = train_error(end);