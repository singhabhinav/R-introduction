#0 --> Very Negative
#1 --> Negative
#2 --> Neutral
#3 --> Positive
#4 --> Very Positive

# Install Java before installing CoreNLP

# Run for the first time

devtools::install_github("statsmaths/coreNLP")
coreNLP::downloadCoreNLP()

# Load the Library
library(coreNLP)

# Initialize CoreNLP
initCoreNLP()

sentence = "the sun did not shine, it was too wet to play. So we sat in the house all that cold, cold, wet day"

output = annotateString(sentence)

sentiment = getSentiment(output)

View(sentiment)
