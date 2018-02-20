clear all; close all; clc;

% Comparison of incremental learning for RBF vs. backprop in two-layer
% perceptron network
%%                  Create data
%Create the column vector containing the points on the interval [0,2pi]
%As well as the training sets, one sinus function and one square function
%Add noise to both training and testing data

%Last part in seperate script

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

%optimal number of RBF nodes
batch_nodes = 38;

%calculate error for batch learning approach
bat_error = batch_rbf(train_vect,train_sin, test_vect,test_sin,sigma,batch_nodes,false);

%% Delta rule
% delta rule using on-line learning

%define constants (optimal constants after earlier parts)
eta = 0.15;
epochs = 4;
delta_nodes = 10;

%create rbf and performe delta-rule
del_error(:) = delta_rbf(train_vect, train_sin, test_vect, test_sin, sigma, eta, epochs, delta_nodes, false);

