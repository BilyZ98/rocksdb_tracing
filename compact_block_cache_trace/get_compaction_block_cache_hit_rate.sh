



in_file=/tmp/block_trace_human_file


awk -F ',' '{print $9,$14}' $in_file | sort | uniq -c 


