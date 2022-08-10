


if(!exists("op_dat_file")) {
    print("dat_file not exist");
    exit;
  } else {
      print("dat file is ".op_dat_file)
    }
set terminal png size 800,400

set output "block_id.png"
set title "op trace time and key"
set xlabel "time(s)"
set ylabel "key id"

#set datafile separator ", "

set key left 

set y2tics 


plot block_file using 1:2 title "block" w p pt 1 
  #op_dat_file using 5:1 title "op" w p axes x1y2

set output "op_time_op_type.png" 

set yrange[-1:2]
plot op_dat_file using 5:2 title "op type " w dots

#  io_file using 4:15 title "io" w p 

#plot io_file  using 4:15 notitle w p 
#plot block_file using 1:2  notitle  w p pt 7 axes x1y2 , \
#   op_dat_file using 5:1 notitle w p  pt 3;
#plot dat_file  using 2:3 notitle w dots lt 2;
