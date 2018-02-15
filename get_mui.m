function [ mui ] = get_mui(x,y,units)

%mui is the middle of the RBF, we place it at the sinusfunction.
mui = [x(1:ceil(length(x)/units):end); y(1:ceil(length(y)/units):end)];

end

