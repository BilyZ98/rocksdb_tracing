
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

dat_file="./trace_data_dir/op_trace-get-0-time_series.txt"


gnuplot -e "dat_file='$dat_file'" trace_dat.gp

