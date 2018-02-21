function [mui, sigma, final_rbf] = findSol3_3(train, mui, sigma, eta, epochs)

%randomize the x data:
% shuffle = randperm(length(x));
% x_rand = x(:,shuffle);

%W = rand(2,length(mui));
%eta_e = 0.15;

%train_error = zeros(1,epochs);
for k = 1:epochs
    %randomize the x data:
    shuffle = randperm(length(train));
    x_rand = train(:,shuffle);
    
    for i =1:length(train)
        rbf = GaussianRBF3_3(x_rand, mui, sigma);
        [~, max_ind] = max(rbf(i,:));

        for j = 1:length(mui)
            if j == max_ind
                mui(:,max_ind) = mui(:,max_ind) - eta*(mui(:,max_ind)-x_rand(:,i));
                sigma(max_ind) = max(0.1,sigma(max_ind)-0.01);
            else
                %mui(:,j) = mui(:,j) - eta_l*(mui(:,j)-x_rand(:,i));
            end

        end
        
        %Use GaussianRBF function to create the phi matrix.
        %it shows how well each datapoint in x fits to each rbf node
%         rbf = GaussianRBF3_3(x_rand, mui, sigma);
%         e = x_rand(:,i) - W*rbf(i,:)';
%         deltaW1 = eta_e*e(1)*rbf(i,:);
%         deltaW2 = eta_e*e(2)*rbf(i,:);
%         W(1,:) = W(1,:) + deltaW1;
%         W(2,:) = W(2,:) + deltaW2;
    end
    
    %train_error(k) = mean(sum((W*rbf' - x_rand).^2));
end
final_rbf = GaussianRBF3_3(x_rand, mui, sigma);
final_rbf(shuffle,:) = final_rbf;
%mui(:,shuffle) = mui;
%sigma(shuffle) = sigma;
%W(:,shuffle) = W;
% test_rbf = GaussianRBF(test, test_mui ,0.8);
% test_f = W*test_rbf';
% [~,idy] = sort(test_f(1,:)); % sort just the first column
% test_f = test_f(:,idy);
% figure
% plot(test_f(1,:),test_f(2,:))
%finalRbf = GaussianRBF3_3(x_rand, mui, sigma);

end