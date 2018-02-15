function [train_error] = batch_rbf(train_vect, train_sin, test_vect, test_sin,sigma,units,doPlot)
%mui is the middle of the RBF, we place it at the sinusfunction.
mui = get_mui(train_vect,train_sin,units);

%x is the data we are using
x = [train_vect; train_sin];

%Use GaussianRBF function to create the phi matrix.
rbf = GaussianRBF(x, mui, sigma);

% the real output f
f = train_sin';

%calculate the new weight
weights = ((rbf'*rbf)^-1)*rbf'*f;

%Test the network
test_mui = get_mui(test_vect,test_sin,units);
test_rbf = GaussianRBF([test_vect; test_sin], test_mui ,sigma);
test_f = test_rbf*weights;
%test_error = mean(abs(test_f-test_sin'));    %(norm(test_rbf*weights-test_sin'))^2
train_error = mean(abs(rbf*weights-train_sin'));

if doPlot
    %plot the comparison   
    figure
    plot(train_sin), hold on, plot(rbf*weights)

    %Plot the test 
    figure
    plot(test_f), hold on, plot(test_sin)
    legend('Test','Real')
end

end

