function [outputArg1] = importTxt(file,class)
% Importing .txt file in given path, and add class label that given.
fid = fopen(file);
tline = fgetl(fid);
doc = [];
while ischar(tline)
    tline(regexp(tline,'[.,?!:"()*''[]]'))=[];
    doc = [doc;string(tline) class];
    tline = fgetl(fid);
end

outputArg1 = doc;
end

