# importing the necessary libraries
from functools import reduce
from matplotlib import style
import pandas as pd
from sklearn import preprocessing
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import seaborn as sns


# we load the CSV file into a DataFrame
all = pd.read_csv("data/all_mf.csv")
all = all.iloc[:, 1:]

# we split the Player variable to delete everything after thr "\"
all['Player'] = all['Player'].str.split('\\').str[0]

# As we're going to perform a KMeans algorithm on the data, I also replaced NaN values with the mean for that variable
all.iloc[:, 5:] = all.iloc[:, 5:].fillna(all.iloc[:, 5:].mean())

# we now begin the statistical part of the script
x = all.iloc[:, 5:].values
scaler = preprocessing.MinMaxScaler()
x_scaled = scaler.fit_transform(x)
X_norm = pd.DataFrame(x_scaled)

pca = PCA(n_components = 2)
reduced = pd.DataFrame(pca.fit_transform(X_norm))

kmeans = KMeans(n_clusters=5)
kmeans = kmeans.fit(reduced)
labels = kmeans.predict(reduced)
centroid = kmeans.cluster_centers_
clusters = kmeans.labels_.tolist()

reduced['cluster'] = clusters
reduced['Player'] = all['Player']
reduced.columns = ['x', 'y', 'cluster', 'player']

# and then the plot to show the clusters
sns.set(style="dark", font_scale = 0.5)
ax = sns.lmplot(x="x", y="y", hue='cluster', data = reduced, legend=False,
fit_reg=False, height = 10, scatter_kws={"s": 50}, markers = ["s", "x", "+", "<", "."])
texts = []
for x, y, s in zip(reduced.x, reduced.y, all['Player']):
  texts.append(plt.text(x, y, s))
ax.set(ylim=(-2, 2))
plt.tick_params(labelsize=10)
plt.xlabel("PC 1", fontsize = 15)
plt.ylabel("PC 2", fontsize = 15)
plt.show()