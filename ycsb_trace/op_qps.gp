


set terminal png size 800,400

set output "op_qps.png"


set xlabel "time(s)"
set ylabel "qps"

plot op_file title "qps " w p ;
