

#     learn 
#    /      \
# apply - teach 
#   

dat_file="./trace_data_dir/op_trace-get-0-time_series.txt"


gnuplot -e "dat_file='$dat_file'" trace_dat.gp

