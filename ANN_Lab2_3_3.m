% ANN_Lab2_3_3
clear all; close all; clc;

%Step 1 is to create the data that will be used (sin(2x) with noise and
%without noise)

%Create the column vector containing the points on the interval [0,2pi]
%As well as the training sets, one sinus function

train_vect = 0:0.1:2*pi;
train_sin = sin(2*train_vect);

%create testing sets
test_vect = 0.05:0.1:2*pi;          
test_sin = sin(2*test_vect);


%create and add noise with zero mean and variance = 0.1
var = 0.1;
gauss_noise = var*randn(1,length(train_vect));
train_sin_noise = train_sin + gauss_noise;
test_sin_noise = test_sin + gauss_noise;

%number of rbf units: Use 15 because that is how many it needs to get error lower than 0.01
units = 15;

%Giva a value to the sigma parameter.
sigma = 0.8;
eta = 0.01;

%create the random rbf's for the beginning of the code
mui = get_random_mui(train_vect, units);

%x is the data we are using
x = [train_vect; train_sin];

%rbf in beginning
figure
plot(train_vect, train_sin), hold on, plot(mui(1,:),mui(2,:),'*')

%randomize the x data:
shuffle = randperm(length(x));
x_rand = x(:,shuffle);

for i =1:length(x)
%Use GaussianRBF function to create the phi matrix.
%it shows how well each datapoint in x fits to each rbf node
rbf = GaussianRBF(x_rand, mui, sigma);

[val, max_ind] = max(rbf(i,:));

for j = 1:length(mui)
    if j == max_ind
        mui(2,max_ind) = mui(2,max_ind) - eta*(mui(2,max_ind)-x_rand(2,i));
    else
        mui(2,j) = mui(2,j) + eta*(mui(2,j)-x_rand(2,i));
    end

end
end

figure
plot(train_vect, train_sin), hold on, plot(mui(1,:),mui(2,:),'*')






