clear all;
close;
clc;
slCharacterEncoding('UTF-8');

%Importing Data
legitimateDocs = importTxt('sms_legitimate.txt','legitimate');
spamDocs = importTxt('sms_spam.txt','spam');
stopwords = importTxt('stopwordsTR.txt','');

dataset = [lower(legitimateDocs);lower(spamDocs)]; %Create dataset by using legitimate and spam SMS

[Training, Testing] = hold_out(dataset); %Splitting Dataset into Test and Training Set

dFreq = containers.Map; %Declaring map object contains Document Frequency of all words
spamWords = containers.Map; %Declaring map object contains Number of occurences each words that it's class label is spam.
legitimateWords = containers.Map; %Declaring map object contains Number of occurences each words that it's class label is legitimate.

numOfSpam = sum(Training(:,2) == 'spam'); %Number of Spam documents in Training Data
numOfLegitimate = sum(Training(:,2) == 'legitimate'); %Number of Legitimate documents in Training Data


for i = 1:length(Training) %Iterate all Training documents
    dfWords = strings; %Words that occured in current document. 
    words = prune(Training(i), stopwords); %Splitting current document into words.
    for j = 1:length(words) %Iterate all words in current document.
        
        if ~any(contains(dfWords,words(j)))
            dfWords = [dfWords words(j)]; %Add word that occured in document
            
            if ~isKey(dFreq, words(j)) %Check current word is not occured before.
                dFreq(words(j)) = 1;
            else
                dFreq(words(j)) = dFreq(words(j))+1;
            end
            
            if (Training(i,2) == "spam") %Check class label of current document.
                if ~isKey(spamWords, words(j)) %Check current word is not in spamWords.
                spamWords(words(j)) = 1;
                else
                spamWords(words(j)) = spamWords(words(j))+1;
                end
            else
                if ~isKey(legitimateWords, words(j)) %Check current word is not in legitimateWords.
                legitimateWords(words(j)) = 1;
                else
                legitimateWords(words(j)) = legitimateWords(words(j))+1;
                end
            end
            
        end
                    
     end          
end

dfreqKeys = keys(dFreq);

for i = 1:length(dfreqKeys)
   if dFreq(string(dfreqKeys(i))) < 5 % Remove words that occuring at most 5 times.
      remove(dFreq,dfreqKeys(i));
   end  
end

spamKeys = keys(spamWords);

for i = 1:length(spamKeys)
   if spamWords(string(spamKeys(i))) < 5 % Remove words that occuring at most 5 times.
      remove(spamWords,spamKeys(i));
   end  
end


pSpam = numOfSpam/595; %Probability of spam docs.
pLegitimate = numOfLegitimate/595; %Probability of spam docs.

%% Naive Bayesian Classification
for j = 1:length(Testing) %Iterate on Testing documents
    testet = prune(Testing(j),stopwords); %Split document into words
    pSpamWord = 1;
    pLegitimateWord = 1;
    for i = 1:length(testet) %Iterate all words in current document.
        %% Check if word is not in word sets and if not give initial value 0
        if ~isKey(spamWords,testet(i))
            spamWords(testet(i)) = 0;
        end
        if ~isKey(legitimateWords,testet(i))
            legitimateWords(testet(i)) = 0;
        end
        if ~isKey(dFreq,testet(i))
            dFreq(testet(i)) = 0;
        end
        %% Laplacian Correction
        if spamWords(testet(i)) == 0
            spamWords(testet(i)) = spamWords(testet(i))+1;
            numOfSpam = numOfSpam+1;
        end
        if legitimateWords(testet(i)) == 0
            legitimateWords(testet(i)) = legitimateWords(testet(i))+1;
            numOfLegitimate = numOfLegitimate+1;
        end
        %% Implement Naive Bayesian Algorithm with multiplying each term with its tf_idf weight. 
        weight = tf_idf(tFreq(Testing(j),testet(i),stopwords), dFreq(testet(i)),length(Training));
        pSpamWord = (spamWords(testet(i))/numOfSpam) * pSpamWord * weight;
        pLegitimateWord = (legitimateWords(testet(i))/numOfLegitimate) * pLegitimateWord *weight;       
    end
    %% Assign documents to defined class label.
    if pSpamWord*pSpam > pLegitimateWord*pLegitimate
        Testing(j,3) = "spam";
    else
        Testing(j,3) = "legitimate";
    end
end

confusion_matrix = confusion_mtx(Testing);
FScore = fScore(confusion_matrix);






