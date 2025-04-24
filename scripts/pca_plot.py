import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from rpy2.robjects import r
from rpy2.robjects.packages import importr
from rpy2.robjects import pandas2ri
import numpy as np

# Activate pandas conversion for R objects
pandas2ri.activate()

# Load your R data
r('''sm.pca <- readRDS("sm.pca_090425.RDS")''')
sm_pca = r['sm.pca']

# Convert R objects to pandas DataFrames
sample_coords = pandas2ri.ri2py(sm_pca.rx2('pca.sample_coordinates'))
gr_v1 = pandas2ri.ri2py(r['GR'].rx2('V1'))
gr_v3 = pandas2ri.ri2py(r['GR'].rx2('V3'))

# Create DataFrame for plotting
plot_df = pd.DataFrame({
    'PC1': sample_coords['PC1'],
    'PC2': sample_coords['PC2'],
    'Group': sample_coords['Group'],
    'Class': sample_coords['Class'],
    'Name': gr_v1
})

# Calculate mean PC values per group
mean_df = plot_df.groupby('Group').agg({'PC1':'mean', 'PC2':'mean'}).reset_index()

# Separate projected and PCA points
projected_data = plot_df[plot_df['Class'] == "Projected"]
pca_data = plot_df[plot_df['Class'] == "PCA"]

# Create the plot
fig = go.Figure()

# Add PCA points (grey)
fig.add_trace(go.Scatter(
    x=-pca_data['PC1'],
    y=-pca_data['PC2'],
    mode='markers',
    marker=dict(color='grey', size=8, opacity=0.5),
    name='PCA Samples',
    text=pca_data['Name'] + '<br>Group: ' + pca_data['Group'],
    hoverinfo='text'
))

# Add projected points (colored by group)
for group in projected_data['Group'].unique():
    group_data = projected_data[projected_data['Group'] == group]
    fig.add_trace(go.Scatter(
        x=-group_data['PC1'],
        y=-group_data['PC2'],
        mode='markers',
        marker=dict(size=10),
        name=group,
        text=group_data['Name'] + '<br>Group: ' + group,
        hoverinfo='text'
    ))

# Add group labels (using mean coordinates)
for _, row in mean_df.iterrows():
    fig.add_annotation(
        x=-row['PC1'],
        y=-row['PC2'],
        text=row['Group'],
        showarrow=False,
        font=dict(size=12),
        xanchor='center',
        yanchor='bottom'
    )

# Update layout
fig.update_layout(
    title='PCA Visualization',
    xaxis_title='PC1 (negative)',
    yaxis_title='PC2 (negative)',
    legend=dict(
        orientation='h',
        yanchor='bottom',
        y=-0.3,
        xanchor='center',
        x=0.5
    ),
    hovermode='closest'
)

# Save as HTML
fig.write_html("PCA_kavkaz_interactive_python.html")

# Alternative: Show in notebook
# fig.show()
