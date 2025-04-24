import pandas as pd
import plotly.express as px

evec_path = "pruned_final_merged_caucas.evec"

data = []
bad_lines = []

with open(evec_path) as f:
    for i, line in enumerate(f):
        if line.startswith("#") or not line.strip():
            continue
        parts = line.strip().split()
        if len(parts) < 4:
            bad_lines.append((i + 1, line.strip()))
            continue
        sample_id = parts[0]
        pc1 = float(parts[1])
        pc2 = float(parts[2])
        population = parts[3]
        data.append((sample_id, pc1, pc2, population))

# Print warnings if needed
if bad_lines:
    print("⚠️ Skipped the following malformed lines:")
    for lineno, content in bad_lines:
        print(f"  Line {lineno}: '{content}'")

# Build DataFrame and plot
df = pd.DataFrame(data, columns=["ID", "PC1", "PC2", "Population"])

fig = px.scatter(
    df, x="PC1", y="PC2", color="Population", hover_name="ID",
    title="PCA of Merged Samples",
    labels={"PC1": "Principal Component 1", "PC2": "Principal Component 2"}
)

fig.write_html("pca_plot_100K.html")
print("✅ Plot saved as 'pca_plot_100K.html'")

