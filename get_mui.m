function [ mui ] = get_mui(x,y,units)

%mui is the middle of the RBF, we place it at the sinusfunction..
x_stepsize = round(linspace(1,length(x),units));
y_stepsize = round(linspace(1,length(y),units));
mui = [x(x_stepsize); y(y_stepsize)];

end

