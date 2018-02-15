function [train_error] = delta_rbf(train_vect, train_sin, test_vect, test_sin, sigma, eta, epochs, units, plotting)
%%% uses delta function with incremental learning algorithm

%mui is the middle of the RBF, we place it at the sinusfunction.
mui = get_mui(train_vect,train_sin,units);

%Initialise weights
weights = zeros(1,units);

for iter = 1:epochs
    %Shuffle the data by random for each epoch
    shuffle = randperm(length(train_vect));
    train_sin = train_sin(:,shuffle);
    test_sin = test_sin(:,shuffle);
    
    %create a phi matrix
    rbf = GaussianRBF(train_sin, mui, sigma);
    rbf = rbf';
    
    for i = 1:length(test_sin)
    
        %instantanious error xi(estimated error)
        e = train_sin(i) - weights*rbf(:,i);
        %xi(iter) = 0.5.*e.^2;
        
        %weight update
        delta_weights = (eta.*e)*rbf(:,i)';
        weights = weights + delta_weights;
        
        %test the data in each epoch
        test_mui = get_mui(test_vect,test_sin,units);
        test_rbf = GaussianRBF([test_vect; test_sin], test_mui ,sigma);
        test_rbf = test_rbf';
        test_f = weights*test_rbf;
    end
    train_error(iter) = mean(abs(train_sin - weights*rbf));
end

%error of the last epoch for comparison
train_error = train_error(end);