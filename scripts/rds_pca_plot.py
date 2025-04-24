import pyreadr
import plotly.express as px

# Load the RDS file into a dictionary (use list() to extract the dataframe)
result = pyreadr.read_r("pca_projection_full.RDS")

# The dataframe will be the first item in the dictionary (index 0)
df = list(result.values())[0]

# Plot the PCA using Plotly
fig = px.scatter(
    df, x="PC1", y="PC2", color="Group", hover_name="Name",
    title="PCA of Ancient and Modern Samples",
    labels={"PC1": "Principal Component 1", "PC2": "Principal Component 2"}
)

# Save the interactive plot as an HTML file
fig.write_html("smartpca_plot_305K.html")
print("✅ Plot saved as 'pca_interactive_plot.html'")
