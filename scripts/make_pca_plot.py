import plotly.express as px

fig = px.scatter(
    data_frame=plot_data,
    x='PC1',
    y='PC2',
    color='political_entity',
    symbol='pop',
    hover_name='genetic_id',
    title='PCA of Ancient and Modern Samples',
    width=800,
    height=600
)

fig.update_layout(
    legend_title_text='Group',
    xaxis_title='PC1',
    yaxis_title='PC2'
)

# Save to HTML file
fig.write_html("pca_plot_caucas.html")

