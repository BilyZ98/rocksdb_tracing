


if(!exists("dat_file")) {
    print("dat_file not exist");
    exit;
  } else {
      print("dat file is ".dat_file)
    }
set terminal png size 800,400

set output "test_op_trace.png"
set title "op trace time and key"
set xlabel "time(s)"
set ylabel "key id"



plot dat_file  using 2:3 notitle w dots lt 2;
