

if(!exists("data_file")) {
    print("data_file needed ")
    exit
  }

print("".data_file)

set output "get-accessed_key_stats.png"
set term png 2000, 600 enhanced font "Times New Roman, 40"


set title "Default" offset 0,-1

set ylabel "key access count"
set yrange [0:400]
set xrange [0:600000000]

plot  data_file using 4 notitle w dots lt 2 
