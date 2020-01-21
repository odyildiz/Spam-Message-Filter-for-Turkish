function [outputArg1] = confusion_mtx(collection)
tp = 0;
tn = 0;
fp = 0;
fn = 0;
for i = 1:length(collection)
    if collection(i,2) == "legitimate" && collection(i,3) == "legitimate" 
        tp = tp+1;
    elseif collection(i,2) == "legitimate" && collection(i,3) == "spam"
        fn = fn+1;
    elseif collection(i,2) == "spam" && collection(i,3) == "legitimate"
        fp = fp+1;
    elseif collection(i,2) == "spam" && collection(i,3) == "spam"
        tn = tn+1;
    end
end

outputArg1 = [tp fn; fp tn];

end

