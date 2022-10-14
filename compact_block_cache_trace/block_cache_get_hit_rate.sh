

in_file=/tmp/block_trace_human_file

get_file=/tmp/compact_block_trace/block_cache_get


awk -F ',' '{if($9==1) {print $1,$14}}' $in_file > $get_file



dat_file=/tmp/compact_block_trace/block_cache_get_hit_rate_change.txt

python3 ./block_cache_get_hit_rate.py $get_file  $dat_file
out_file=/tmp/compact_block_trace/block_cache_get_hit.png

echo "out_file is $out_file"


./plot.sh $dat_file $out_file


./block_cache_get_hit_rate_change_dur.sh
