clear all; close all; clc;

%%                  Create data
%Create the column vector containing the points on the interval [0,2pi]
%As well as the training sets, one sinus function and one square function
%Add noise to both training and testing data

%create training data
train_vect = 0:0.1:2*pi;
train_sin = sin(2*train_vect);
%train_square = square(2*train_vect);       %not needed for this part

%create testing sets
test_vect = 0.05:0.1:2*pi;          
test_sin = sin(2*test_vect);
%test_square = square(2*test_vect);         %not needed for this part

%create and add noise with zero mean and variance = 0.1
var = 0.1;
gauss_noise = var*randn(1,length(train_vect));
train_sin = train_sin + gauss_noise;
test_sin = test_sin + gauss_noise;

%number of rbf units (will be determined by the following code)
%units = 15;

%Create RBF
sigma = 0.8;

%% Batch learning

%Create a for loop to find when the error goes below 0.1, 0.01 and 0.001.
bat_error = zeros(length(5:60));
first = true;
second = true;
third = true;
fprintf('BATCH LEARNING:\nFor the sinus \n')
for i = 5:60
    bat_error(i) = batch_rbf(train_vect,train_sin, test_vect,test_sin,sigma,i,false);
    if bat_error(i)<0.1 && first
        fprintf('Below 0.1, error is %.4f, nr of units = %d \n',bat_error(i),i)
        first = false;
    end
    
    if bat_error(i)<0.01 && second
        fprintf('Below 0.01, error is %.4f, nr of units = %d \n',bat_error(i),i)
        second = false;
    end
    
    if bat_error(i)<0.001 && third
        fprintf('Below 0.001, error is %.4f, nr of units = %d \n',bat_error(i),i)
        third = false;
    end    
end

%% Delta rule

%define constants
eta = 0.2;
epochs = 4;

% %Shuffle the data by random
% shuffle = randperm(length(train_vect));
% train_sin = train_sin(:,shuffle);
% test_sin = test_sin(:,shuffle);

%Create a for loop to find when the error goes below 0.1, 0.01 and 0.001.
del_error = zeros(length(5:60),1);
first = true;
second = true;
third = true;
fprintf('DELTA RULE:\nFor the sinus \n')

for i = 5:60            
    del_error(i) = delta_rbf(train_vect,train_sin, test_vect,test_sin, sigma, eta, epochs, i,false);
    if del_error(i)<0.1 && first
        fprintf('Below 0.1, error is %.4f, nr of units = %d \n',del_error(i),i)
        first = false;
    end
    
    if del_error(i)<0.01 && second
        fprintf('Below 0.01, error is %.4f, nr of units = %d \n',del_error(i),i)
        second = false;
    end
    
    if del_error(i)<0.001 && third
        fprintf('Below 0.001, error is %.4f, nr of units = %d \n',del_error(i),i)
        third = false;
    end    
end
