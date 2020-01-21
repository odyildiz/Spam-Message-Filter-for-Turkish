# Spam Message Filter for Turkish Language

This is a MATLAB project that try to filtering spam messages for Turkish.

## Text Files
sms_legitimate.txt = Contains legitimate messages.

sms_spam.txt = Contains spam messages.

stopwordsTR.txt = Contains stop words for Turkish.

## Methods
- **Splitting:** Hold-out Method (%70 Training - %30 Test) for evaluation.
- **Removing punctiations:** " [.,?!:"()* " These punctuations has removed.
- **Removing stop words:** Remove stop words that in "stopwordsTR.txt".
- **Stemming:** If a word has more than 5 letter took first 5 letter as root for stemming.
- **Term Selection:** Remove all terms occuring in at most 4 documents.
- **Classification:** Naive Bayesian Algorithm has used for classification.
