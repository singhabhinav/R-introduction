
# coding: utf-8

# In[2]:


import networkx as nx


# In[3]:


G_symmetric = nx.Graph()
G_symmetric.add_edge('Amitabh Bachchan','Abhishek Bachchan')
G_symmetric.add_edge('Amitabh Bachchan','Aamir Khan')
G_symmetric.add_edge('Amitabh Bachchan','Akshay Kumar')
G_symmetric.add_edge('Amitabh Bachchan','Dev Anand')
G_symmetric.add_edge('Abhishek Bachchan','Aamir Khan')
G_symmetric.add_edge('Abhishek Bachchan','Akshay Kumar')
G_symmetric.add_edge('Abhishek Bachchan','Dev Anand')
G_symmetric.add_edge('Dev Anand','Aamir Khan')


# In[4]:


get_ipython().magic('matplotlib inline')

nx.draw_networkx(G_symmetric)


# In[5]:


G_asymmetric = nx.DiGraph()
G_asymmetric.add_edge('A','B')
G_asymmetric.add_edge('A','D')
G_asymmetric.add_edge('C','A')
G_asymmetric.add_edge('D','E')


# In[6]:


nx.spring_layout(G_asymmetric)
nx.draw_networkx(G_asymmetric)


# In[7]:


G_weighted = nx.Graph()
G_weighted.add_edge('Amitabh Bachchan','Abhishek Bachchan', weight=10)
G_weighted.add_edge('Amitabh Bachchan','Aaamir Khan', weight=8)
G_weighted.add_edge('Amitabh Bachchan','Akshay Kumar', weight=11)
G_weighted.add_edge('Amitabh Bachchan','Dev Anand', weight=1)
G_weighted.add_edge('Abhishek Bachchan','Aaamir Khan', weight=4)
G_weighted.add_edge('Abhishek Bachchan','Akshay Kumar',weight=7)
G_weighted.add_edge('Abhishek Bachchan','Dev Anand', weight=1)
G_weighted.add_edge('Dev Anand','Aaamir Khan',weight=1)


# In[8]:


nx.degree(G_symmetric, 'Dev Anand')


# In[9]:


nx.degree(G_asymmetric, 'D')


# In[10]:


nx.clustering(G_symmetric, 'Aamir Khan')


# In[11]:


nx.average_clustering(G_symmetric)


# In[12]:


nx.shortest_path(G_symmetric, 'Dev Anand', 'Akshay Kumar')


# In[13]:


nx.degree_centrality(G_symmetric)


# In[14]:


nx.eigenvector_centrality(G_symmetric)


# In[15]:


betCent = nx.betweenness_centrality(G_symmetric)
betCent


# In[16]:


sorted(betCent, key=betCent.get, reverse=True)[:5]


# In[17]:


G_fb = nx.read_edgelist("facebook_combined.txt", create_using = nx.Graph(), nodetype=int)


# In[18]:


nx.info(G_fb)


# In[19]:


sorted(betCent, key=betCent.get, reverse=True)[:5]

