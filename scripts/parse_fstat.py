import pandas as pd
import sys
import os

# the script takes the first argument after scriptname as input file to work with 
file_path = sys.argv[1]

# reading input file 
with open(file_path, 'r') as f:
    file_lines = f.readlines()

result_lines = [line.strip() for line in file_lines if "result:" in line]
data = [line.strip("result:").split() for line in result_lines]

#print(data)
if len(data[0]) == 9:
    df = pd.DataFrame(data, columns = ["pop1", "pop2", "pop3", "pop4", "f4", "zscore", "abba", "baba", "n_snps"])
    
    # save the results in a file
    base_name = os.path.splitext(sys.argv[1])[0]  # Removes the extension
    out_file = base_name + "_filtered.txt"
    df.to_csv(out_file, index=False)

    print(f"Filtered rows saved to {out_file}")
else:
    print("Check the number of columns!")
