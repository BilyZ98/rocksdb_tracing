

if(!exists("output_file")) {
    print("output_file not exists")
    exit
  } else {
      print("output_file is".output_file)
  }


print("input file is".input_file)

set output  output_file
set terminal png size 800,400


#set yrange[:1000]
#set yrange [0:]
plot input_file using :7 w  lines 
#input_file using 1:3 w dots, \
#input_file using 1:4 w lines
