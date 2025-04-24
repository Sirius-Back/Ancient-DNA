import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load the data
FILENAME = "f3_paper_2.txt"  # Replace with your actual file path
d = pd.read_csv(
    FILENAME, 
    sep='\s+', 
    names=["Source 1", "Source 2", "Target", "f_3", "std.err", "Z", "SNPs"]
)


# Sort the data by the 'F3' column
d_sorted = d.sort_values(by="f_3", ascending=False)

print(d_sorted.head())

# Define the y-axis range
y = range(len(d_sorted))

# Determine colors based on Z value
# Define significance thresholds for coloring
d_sorted['color'] = np.where(
        abs(d_sorted['Z']) > 3, 'orange', 'lightblue'
)

print(d_sorted['color'])
print(d_sorted['color'].unique())
print(d_sorted['color'].dtype)

# Create the plot
plt.figure(figsize=(6, 8))

colors = d_sorted['color'].tolist() 

plt.scatter(d_sorted['f_3'], y, c=d_sorted['color'], s=100, edgecolor='k')

plt.axvline(x = 0)
# Add labels and legend
plt.yticks(y, d_sorted["Target"])  # Use the 'C' column as y-axis labels
plt.xlabel("F3")
plt.title("F3 Statistics with Significance")

# Create a custom legend for the colors
import matplotlib.patches as mpatches
green_patch = mpatches.Patch(color='orange', label='|Z| > 3 (Significant)')
blue_patch = mpatches.Patch(color='lightblue', label='|Z| ≤ 3 (Not Significant)')
plt.legend(handles=[green_patch, blue_patch], loc="upper right")

# Save the plot as a PDF file
OUTPUT_PDF = "f3_plot.pdf"  # Specify the output file name
plt.savefig(OUTPUT_PDF, format="pdf", bbox_inches="tight")
plt.close()

print(f"Plot saved as {OUTPUT_PDF}")

