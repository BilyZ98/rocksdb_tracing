

in_file=/tmp/compact_block_trace/block_cache_get

dat_file=/tmp/compact_block_trace/block_cache_get_hit_rate_change_dur.txt

python3 ./block_cache_get_hit_rate_change_dur.py $in_file $dat_file

out_file=/tmp/compact_block_trace/block_cache_get_hit_rate_change_dur.png
echo "out file is:$out_file"


./plot.sh $dat_file $out_file



