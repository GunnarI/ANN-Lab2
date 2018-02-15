function [train_error] = delta_rbf(train_vect, train_sin, test_vect, test_sin, sigma, eta, epochs, units, plotting)
%%% uses delta function with incremental learning algorithm

%mui is the middle of the RBF, we place it at the sinusfunction.
mui = get_mui(train_vect,train_sin,units);

%create a phi matrix
rbf = GaussianRBF(train_sin, mui, sigma);
rbf = rbf';

%Initialise weights
weights = zeros(1,units);

for iter = 1:epochs
    
    %calculate error for each epoch
    train_error(iter) = mean(abs(weights*rbf - train_sin));
    
    %instantanious error xi(estimated error is "target")
    xi = 0.5 .* (train_sin - weights*rbf).^2;
    
    %weight update
    delta_weights = (eta.*(train_sin - weights*rbf))*rbf';
    weights = weights + delta_weights;
    
    %test the data in each epoch
    test_mui = get_mui(test_vect,test_sin,units);
    test_rbf = GaussianRBF([test_vect; test_sin], test_mui ,sigma);
    test_rbf = test_rbf';
    test_f = weights*test_rbf;
     
end

train_error = mean(train_error);