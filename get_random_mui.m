function [ mui ] = get_random_mui(x,units)

%mui is the middle of the RBF, we place it at randomly between -1 and 1
x_stepsize = round(linspace(1,length(x),units));

a = -1;
b = 1;
randomnr = (b-a).*rand(1,units) + a;

mui = [x(x_stepsize); randomnr];

end
