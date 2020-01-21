function [outputArg1] = tf_idf(tFreq,dFreq,N)
%Finding tf_idf weight with given term frequemcy"tFreq" and document frequency"dFreq".
if dFreq == 0
   dFreq = dFreq+1; 
end
outputArg1 = tFreq*log(N/dFreq);

end

