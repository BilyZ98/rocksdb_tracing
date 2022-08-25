
# first we will plot the simplest plot for now, then we will put 3 level 
# trace info into one figure so that we can get some insight.


# op level plot 
# what data should we plot ? 
# latency ? 
# key size 
# 

#     learn 
#    /      \
# apply - teach 
#   

# op_dat_file="./trace_data_dir/op_trace-get-0-time_series.txt"
op_dat_file=${1:-"./trace_data_dir/op_trace-human_readable_trace.txt"}
block_trace_file=${2:-"./trace_data_dir/block_trace_human_file"}

tmp_block_name="/tmp/block_tr_file"
dot_removed_block_trace_dat=`cat $block_trace_file | tr ',' ' ' > $tmp_block_name`


io_file=${3:-"./trace_data_dir/io_trace_res"}

output_file=${4:-"/tmp/output.png"}

gnuplot -e "op_dat_file='$op_dat_file'" \
  -e "block_file='$tmp_block_name'" \
  -e "io_file='$io_file'" \
  -e "output_file='$output_file'" \
  trace_dat.gp

