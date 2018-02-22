function [mui, sigma, final_rbf] = findSol3_3Part3(train, mui, sigma, eta, eta_l, epochs)

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
                sigma(max_ind) = max(0.2,sigma(max_ind)-0.01);
            else
                mui(:,j) = mui(:,j) - eta_l*(mui(:,j)-x_rand(:,i));
            end

        end
    end
end
final_rbf = GaussianRBF3_3(x_rand, mui, sigma);
final_rbf(shuffle,:) = final_rbf;

end