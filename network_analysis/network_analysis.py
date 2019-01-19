import networkx as nx

# Symmetric Networks

G_symmetric = nx.Graph()
G_symmetric.add_edge('Amitabh Bachchan','Abhishek Bachchan')
G_symmetric.add_edge('Amitabh Bachchan','Aamir Khan')
G_symmetric.add_edge('Amitabh Bachchan','Akshay Kumar')
G_symmetric.add_edge('Amitabh Bachchan','Dev Anand')
G_symmetric.add_edge('Abhishek Bachchan','Aamir Khan')
G_symmetric.add_edge('Abhishek Bachchan','Akshay Kumar')
G_symmetric.add_edge('Abhishek Bachchan','Dev Anand')
G_symmetric.add_edge('Dev Anand','Aamir Khan')


# %matplotlib inline

get_ipython().magic('matplotlib inline')

# Draw Symmetric Network

nx.draw_networkx(G_symmetric)


# Asymmetric Networks

G_asymmetric = nx.DiGraph()
G_asymmetric.add_edge('A','B')
G_asymmetric.add_edge('A','D')
G_asymmetric.add_edge('C','A')
G_asymmetric.add_edge('D','E')


# Draw Asymmetric Network

nx.spring_layout(G_asymmetric)
nx.draw_networkx(G_asymmetric)


# Weighted Networks

G_weighted = nx.Graph()
G_weighted.add_edge('Amitabh Bachchan','Abhishek Bachchan', weight=10)
G_weighted.add_edge('Amitabh Bachchan','Aaamir Khan', weight=8)
G_weighted.add_edge('Amitabh Bachchan','Akshay Kumar', weight=11)
G_weighted.add_edge('Amitabh Bachchan','Dev Anand', weight=1)
G_weighted.add_edge('Abhishek Bachchan','Aaamir Khan', weight=4)
G_weighted.add_edge('Abhishek Bachchan','Akshay Kumar',weight=7)
G_weighted.add_edge('Abhishek Bachchan','Dev Anand', weight=1)
G_weighted.add_edge('Dev Anand','Aaamir Khan',weight=1)

# Draw Weighted Network

nx.draw_networkx(G_weighted)


# Network Connectivity - Degree

nx.degree(G_symmetric, 'Dev Anand')

# Network Connectivity - Local Clustering Coefficient

nx.clustering(G_symmetric, 'Aamir Khan')

# Network Connectivity - Average Clustering Coefficient

nx.average_clustering(G_symmetric)

# Network Connectivity - Distance

nx.shortest_path(G_symmetric, 'Dev Anand', 'Akshay Kumar')

# Network Influencers - Degree Centrality

nx.degree_centrality(G_symmetric)

# Network Influencers - Eigenvector Centrality

nx.eigenvector_centrality(G_symmetric)

# Network Influencers - Betweenness Centrality

betCent = nx.betweenness_centrality(G_symmetric)

sorted(betCent, key=betCent.get, reverse=True)[:5]

# Aggregated network of ten individuals’ Facebook friends list

G_fb = nx.read_edgelist("facebook_combined.txt", create_using = nx.Graph(), nodetype=int)

nx.info(G_fb)

betCent = nx.betweenness_centrality(G_fb)

sorted(betCent, key=betCent.get, reverse=True)[:5]
