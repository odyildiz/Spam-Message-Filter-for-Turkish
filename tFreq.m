function [output] = tFreq(document,word, stopwords)
%Finding Term Frequency of given "word" in given "document".
pruned = prune(document, stopwords);
counter = 0;
for i = 1:length(pruned)
   if word == pruned(i)
      counter = counter+1;     
   end   
end

output = counter;
end

