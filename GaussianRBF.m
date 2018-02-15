function [rbf] = GaussianRBF(x, mui, sigma )

%check how the rbf behaves regarding to the input data.
%let all input run through all rbf (mui) and check how they perform.
for i = 1:length(mui)
    for j = 1:length(x)
        rbf(j,i) = exp((-(norm(x(:,j)-mui(:,i))).^2)/(2*sigma^2));
    end
end

end

