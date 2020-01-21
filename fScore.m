function [fscore] = fScore(confMtr)

tp = confMtr(1,1);
fn = confMtr(1,2);
fp = confMtr(2,1);
tn = confMtr(2,2);

precision = tp/(tp+fp);
recall = tp/(tp+fn);

fscore = (2*precision*recall)/(precision+recall);

end

