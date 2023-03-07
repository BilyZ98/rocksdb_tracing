

function plot() {
  input_file=$1

  out_file=$2

  gnuplot -e "input_file='$input_file'" \
    -e "output_file='$out_file'" \
    plot.gp
}


plot $1 $2
