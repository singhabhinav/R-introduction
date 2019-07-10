#!/usr/bin/env python
# coding: utf-8

# In[55]:


get_ipython().system('pip install -U textblob')


# In[56]:


# Download nltk corpora

get_ipython().system('python -m textblob.download_corpora')


# In[52]:


# Import the library

from textblob import TextBlob


# In[53]:


blob = TextBlob("Textblob is amazingly simple to use. What great fun!")
blob.sentiment.polarity


# In[57]:


blob = TextBlob("I hate you.")
blob.sentiment.polarity


# In[61]:


blob = TextBlob("Textblob is amazingly simple to use. What great fun!. I hate you.")
for sentence in blob.sentences:
    print(sentence)
    print(sentence.sentiment.polarity)
    print("\n")


# In[ ]:




