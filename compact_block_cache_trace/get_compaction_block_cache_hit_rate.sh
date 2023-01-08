



# in_file=/tmp/block_trace_human_file
in_file=/tmp/standard_block_cache_trace_human_file


awk -F ',' '{print $9,$14}' $in_file | sort | uniq -c 


