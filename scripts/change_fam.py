import pandas as pd

# load data
table1 = pd.read_csv('~/ancient/data/Kavkaz2024_HO.ind', delim_whitespace=True, header=None)
table2 = pd.read_csv('~/ancient/Admixture/kavkaz_admixture_pruned.fam', delim_whitespace=True, header=None)

print(table1.shape, table2.shape)

# rename columns of tables
table1.columns = ['sampleID', 'sex', 'popID']
table2.columns = ['index', 'sampleID', 'col3', 'col4', 'col5', 'col6']

joint_table = table2.merge(table1, on='sampleID', how='left')

final_table = []

for _, row in joint_table.iterrows():
	if len(row) == 8:
		reordered_row = [row[-1]] + row[1:-2].tolist()
	else:
		reordered_row = ["NA"] + row.tolist()
	final_table.append(reordered_row)

final_table_df = pd.DataFrame(final_table)

final_table_df.to_csv('final_table', sep=' ', index=False, header=False)
