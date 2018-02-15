clear all; close all; clc;

%Create the column vector containing the points on the interval [0,2pi]
%As well as the training sets, one sinus function and one square function
train_vect = 0:0.1:2*pi;
train_sin = sin(2*train_vect);
train_square = square(2*train_vect);

%create testing sets
test_vect = 0.05:0.1:2*pi;          
test_sin = sin(2*test_vect);
test_square = square(2*test_vect);

%number of rbf units:
units = 15;

%Create RBF
sigma = 0.8;


%code to find the best combination of units of rbf and sigma to get lowest error
%______________________________________________________________________________
% vec_sig = 0.01:0.01:1;
% min_error = inf;
% sin_error = zeros(60,length(vec_sig));
% for i = 10:60
%     for j = 1:length(vec_sig)
%         sin_error(i,j) = batch_rbf(train_vect,train_square, test_vect,test_square,vec_sig(j),i,false);
%         if sin_error(i,j)<min_error
%             min_error=sin_error(i,j);
%             nr_units = i;
%             nr_sigma = vec_sig(j);
%         end
%     end
% end
%________________________________________________________________________________

%Create a for loop to find when the error goes below 0.1, 0.01 and 0.001.
sin_error = zeros(length(5:60));
first = true;
second = true;
third = true;
fprintf('For the sinus \n')
for i = 5:60
    sin_error(i) = batch_rbf(train_vect,train_sin, test_vect,test_sin,sigma,i,false);
    if sin_error(i)<0.1 && first
        fprintf('Below 0.1, error is %.4f, nr of units = %d \n',sin_error(i),i)
        first = false;
    end
    
    if sin_error(i)<0.01 && second
        fprintf('Below 0.01, error is %.4f, nr of units = %d \n',sin_error(i),i)
        second = false;
    end
    
    if sin_error(i)<0.001 && third
        fprintf('Below 0.001, error is %.4f, nr of units = %d \n',sin_error(i),i)
        third = false;
    end    
end

%Do the same but for the square function
sq_error = zeros(length(5:30));
first_sq = true;
second_sq = true;
third_sq = true;
fprintf(' \nFor the square \n')
for i = 5:30
    sq_error(i) = batch_rbf(train_vect,train_square, test_vect,test_square,sigma,i,false);
    if sq_error(i)<0.1 && first_sq
        fprintf('Below 0.1, error is %.4f, nr of units = %d \n',sq_error(i),i)
        first_sq = false;
    end
    
    if sq_error(i)<0.01 && second_sq
        fprintf('Below 0.01, error is %.4f, nr of units = %d \n',sq_error(i),i)
        second_sq = false;
    end
    
    if sq_error(i)<0.001 && third_sq
        fprintf('Below 0.001, error is %.4f, nr of units = %d \n',sq_error(i),i)
        third_sq = false;
    end    
end
           
%Use the batch_rbf function to be awesome for the sinus function
%sin_error = batch_rbf(train_vect,train_sin, test_vect,test_sin,sigma,units,false)

%For square function
%square_error = batch_rbf(train_vect,train_square, test_vect,test_square,sigma,units,false)



%% Repeat for square function


