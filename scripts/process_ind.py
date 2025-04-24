input_file = "merged_kavkaz_fstat.ind"
output_file = "clened.fam"


with open(input_file, "r") as infile, open(output_file, "w") as outfile:
    for line in infile:
        out_line = line.split(":", 1)[-1]
        outfile.write(out_line)
