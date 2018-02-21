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

epochs = 100;

%Giva a value to the sigma parameter.
sigma = ones(1,units)*0.8;
eta = 0.05;
eta_l = 0.001;

%create the random rbf's for the beginning of the code
train_mui = rand(2,units);%get_random_mui(train_vect, units);
train_mui(1,:) = train_mui(1,:)*train_vect(end);
train_mui(2,:) = train_mui(2,:)*2 - 1;

test_mui = rand(2,units);
test_mui(1,:) = test_mui(1,:)*test_vect(end);
test_mui(2,:) = test_mui(2,:)*2-1;

%x is the data we are using
train_clean = [train_vect; train_sin];
train_noise = [train_vect; train_sin_noise];

test_clean = [test_vect; test_sin];
test_noise = [test_vect; test_sin_noise];

%rbf in beginning
figure
plot(train_vect, train_sin), hold on, plot(train_mui(1,:),train_mui(2,:),'*')

[mui_clean, W_clean, test_f_clean, train_error_clean] = ...
    findSol3_3(train_clean, test_clean, train_mui, test_mui, sigma, eta, epochs);
[mui_noise, W_noise, test_f_noise, train_error_noise] = ...
    findSol3_3(train_noise, test_noise, train_mui, test_mui, sigma, eta, epochs);



figure
plot(train_vect, train_sin), hold on, plot(mui_clean(1,:),mui_clean(2,:),'*')
figure
plot(train_vect, train_sin,'r--',train_vect, train_sin_noise,'b')
hold on
plot(mui_noise(1,:),mui_noise(2,:),'g*')






