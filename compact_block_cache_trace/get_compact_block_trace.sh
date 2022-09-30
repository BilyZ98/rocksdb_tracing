


all_block_trace_file="/tmp/block_trace_human_file"


output_compact_block_trace_file="/tmp/compact_block_trace/compact_block_trace_file"


awk -F ',' '{if($9 == "10" && $14 == "1"){print}}' $all_block_trace_file > $output_compact_block_trace_file

