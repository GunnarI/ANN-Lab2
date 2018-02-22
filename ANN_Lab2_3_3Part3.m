clear all; clc; close all;
ballist = importBallist('ballist.dat');
balltest = importBalltest('balltest.dat');
angle_train = ballist(:,1)';
vel_train = ballist(:,2)';
dist_train = ballist(:,3)';
height_train = ballist(:,4)';

angle_test = balltest(:,1)';
vel_test = balltest(:,2)';
dist_test = balltest(:,3)';
height_test = balltest(:,4)';

train_input = [vel_train;angle_train];
train_output = [dist_train;height_train];

test_input = [vel_test;angle_test];
test_output = [dist_test;height_test];

units = 25;
epochs_CL = 50;
sigma_CL = ones(1,units)*0.8;
mui = rand(2,units);
eta = 0.1;
eta_l = 0;

epochs_delta = 100;
sigma_delta = ones(1,units)*0.8;

[mui_result, sigma_result, rbf_result1] = ...
    findSol3_3Part3(train_input,mui,sigma_CL,eta,eta_l,epochs_CL);

[W_result, rbf_result, train_error, test_f] =...
    delta_rbf_3_3Part3(train_output, test_output, eta, epochs_delta, mui_result, sigma_delta, units, false);

plot(train_input(1,:),train_input(2,:),'b*',mui_result(1,:),mui_result(2,:),'ro')
title('RBF mapping of training input data')
xlabel('Velocity')
ylabel('Angle')
legend('Input data','RBF nodes')
figure
train_res = W_result*rbf_result;
plot(train_output(1,:),train_output(2,:),'b*',train_res(1,:),train_res(2,:),'rd')
title('Training Output - the result of training')
xlabel('Distance')
ylabel('Height')
legend('Original data','Algorithm output')
figure
plot(test_output(1,:),test_output(2,:),'b*',test_f(1,:),test_f(2,:),'rd')
title('Testing Output')
xlabel('Distance')
ylabel('Height')
legend('Original data','Algorithm output')

