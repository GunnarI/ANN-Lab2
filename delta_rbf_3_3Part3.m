function [W, rbf, train_error, test_f] = ...
    delta_rbf_3_3Part3(train, test, eta, epochs, mui, sigma, units, plotting)

%%% uses delta function with incremental learning algorithm.

%mui is the middle of the RBF, we place it at the sinusfunction.

%Initialise weights
W = zeros(2,units);
test_f = zeros(2,length(train));

train_error = zeros(1,epochs);

for epoch = 1:epochs
    %Shuffle the data by random for each epoch
    shuffle = randperm(length(train));
    train = train(:,shuffle);
    test = test(:,shuffle);
    
    rbf = GaussianRBF3_3(train, mui, sigma);%rbf(:,shuffle);
    rbf = rbf';
    
    %update weights for each datapoint
    for i = 1:length(train)
    
        %instantanious error xi(estimated error)
        e = train(:,i) - W*rbf(:,i);
        %xi(iter) = 0.5.*e.^2;                  %is built in delta_weight function
        
        %weight update
        deltaW1 = eta*e(1)*rbf(:,i)';
        deltaW2 = eta*e(2)*rbf(:,i)';
        W(1,:) = W(1,:) + deltaW1;
        W(2,:) = W(2,:) + deltaW2;
    end
    test_rbf = GaussianRBF3_3(test, mui, sigma);
    test_f = W*test_rbf';

    rbf(:,shuffle) = rbf;
    train(:,shuffle) = train;
    test(:,shuffle) = test;
    test_f(:,shuffle) = test_f;
    
    %Calculate error
    train_error(epoch) = mean(sum((W*rbf - train).^2));
end


if plotting
    %plotting of training and testing function with output
    figure(1)
    str = sprintf('Epoch: %d, Hidden Nodes %d', epoch, units);
    %plot training function
    subplot(2,1,1)
    plot(train(2,:)), hold on
    plot(W*rbf), hold off
    title({'Training function';str}),
    legend('original','output')
    
    %plot testing function
    subplot(2,1,2)
    plot(test(2,:)), hold on
    plot(test_f), hold off
    title({'Testing function';str})
    legend('original','output')
    
end
