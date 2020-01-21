function [Training,Testing] = hold_out(input)
% Split given document into Training and Testing set by given percentage "P"
[m,n] = size(input) ;
P = 0.70 ;
idx = randperm(m)  ;
Training = input(idx(1:round(P*m)),:) ; 
Testing = input(idx(round(P*m)+1:end),:) ;
end

