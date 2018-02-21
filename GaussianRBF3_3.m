function [rbf] = GaussianRBF3_3(x, mui, sigma )

%check how the rbf behaves regarding to the input data.
%let all input run through all rbf (mui) and check how they perform.
rbf = zeros(length(x),length(mui));
for i = 1:length(mui)
    for j = 1:length(x)
        rbf(j,i) = exp((-(norm(x(:,j)-mui(:,i))).^2)/(2*sigma(i)^2));
    end
end

end

