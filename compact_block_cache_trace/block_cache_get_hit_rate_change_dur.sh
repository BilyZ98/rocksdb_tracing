


caller_log=$1
block_size=$2
out_suffix=$3

# in_file=/tmp/compact_block_trace/block_cache_get_and_compact
in_file=$caller_log
# in_file=/tmp/compact_block_trace/standard_block_cache_get_and_compact

dat_file=/tmp/compact_block_trace/block_cache_hit_rate_change_dur_${block_size}_${out_suffix}.txt
# dat_file=/tmp/compact_block_trace/standard_block_cache_get_hit_rate_change_dur.txt

python3 ./block_cache_get_hit_rate_change_dur.py $in_file $dat_file

# out_file=/tmp/compact_block_trace/standard_block_cache_get_hit_rate_change_dur.png
out_file=/tmp/compact_block_trace/block_cache_get_hit_rate_change_dur_${block_size}_${out_suffix}.png
echo "out file is:$out_file"


./plot.sh $dat_file $out_file



