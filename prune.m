function [outputArg1] = prune(document, stopwords)
%Split given "document" into its' words, remove stopwords and stemming.
    words = strsplit(document);
    for j = 1:length(words)       
        if  ~any(contains(stopwords,words(j)))           
            if strlength(words(j)) > 5 
               words(j) = extractBefore(words(j),6); % Taking first 5 character as root of word is giving good result for stemming in Turkish.
            end
            
        end
    end
    outputArg1 = words;
    
end

