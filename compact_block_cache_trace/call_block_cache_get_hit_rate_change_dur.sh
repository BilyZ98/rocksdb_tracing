


pushd ../build
rm -rf ./*
cmake -DCMAKE_BUILD_TYPE=Debug -DROCKSDB_BUILD_SHARED=0 .. && make -j8 && ../build/db_bench --block_size=16384 --compression_type=none -mix_get_ratio=0.1 -mix_seek_ratio=0.1 -mix_put_ratio=0.8  --benchmarks=mixgraph -num=20000000 -readwritepercent=50 -cache_size=50485760
# -key_dist_a=0.1 -key_dist_b=0.1 

# cache size is 100 MB 
# make -j8 && gdb --args  ../build/db_bench --compression_type=none   --benchmarks=readrandomwriterandom -num=20000000 -readwritepercent=50 -cache_size=104857600
# readrandomwriterandom
popd

./evict_block_analyze.sh
block_acc_pat=(1 3 10)
for i in "${block_acc_pat[@]}"; do
  awk  -v access_type=$i -F ',' '{if($9 == access_type){print $1, $14}}' /tmp/block_trace_human_file  > /tmp/compact_block_trace/block_cache_get_and_compact
./block_cache_get_hit_rate_change_dur.sh $i
done
