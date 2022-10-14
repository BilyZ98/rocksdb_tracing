

print("infile:".in_file)

print("outfile:".out_file)


set output out_file

set terminal png size 800,400

plot in_file using  1:(1) smooth cumulative w lp
