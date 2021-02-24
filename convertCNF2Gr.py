import sys
import argparse

from htd_validate.utils.graph import Graph

parser = argparse.ArgumentParser(description = "converts dimacs .cnf files to .gr files, keeping the number of nodes from the cnf")
parser.add_argument("-f", "--file-output", action = "store", dest = "output_file", help = "saves the output to the specified file") 
parser.add_argument("input_file", nargs = "?", help = "some .cnf file")
args = parser.parse_args()

if not args.input_file:
    parser.print_help()
    sys.exit(1)
else:
    input_file = args.input_file

if args.output_file:
    output_file = args.output_file
else:
    output_file = input_file.split(".")[0]+"_new.gr"

with open(input_file, "r") as f_in:
    header = f_in.readline()
    while header.split()[0] != "p":
        header = f_in.readline()
    num = header.split()[2]

g = Graph.from_file(input_file)
#g.write_gr(sys.stdout) #open(sys.stdout, "w"))
f_out = open(output_file, "w")
g.write_gr(f_out, False) #open(sys.stdout, "w"))

