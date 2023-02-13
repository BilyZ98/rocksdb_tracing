
branches=("lookup_compaction_orig" "compaction_blocks_to_lru_end")

for branch in "${branches[@]}"; 
do

  git checkout $branch
pushd ../build
rm -rf ./*
cmake -DCMAKE_BUILD_TYPE=Release -DROCKSDB_BUILD_SHARED=0 .. && make -j16 #--block_size=16384
# -key_dist_a=0.1 -key_dist_b=0.1 

# cache size is 100 MB 
# make -j8 && gdb --args  ../build/db_bench --compression_type=none   --benchmarks=readrandomwriterandom -num=20000000 -readwritepercent=50 -cache_size=104857600
# readrandomwriterandom
popd

if [[ ! -d "/tmp/compact_block_trace" ]];
then 
  mkdir -p /tmp/compact_block_trace
fi

block_sizes=( 4096 16384 )
for block_size in "${block_sizes[@]}"; do 
  # drop pagecache and dentries 
  sync; echo 3 | sudo tee /proc/sys/vm/drop_caches
  ../build/db_bench  --block_size=16384 --compression_type=none -mix_get_ratio=0.1 -mix_seek_ratio=0.1 -mix_put_ratio=0.8  --benchmarks=mixgraph -num=20000000 -readwritepercent=50 -cache_size=104857600

  # get trace log 
  ./evict_block_analyze.sh
  block_acc_pat=(1 3 10)
  for i in "${block_acc_pat[@]}"; do
    # get blokck cache access info for each caller
    caller_log=/tmp/compact_block_trace/block_cache_access_caller_${branch}_${block_size}_${i}
    awk  -v access_type=$i -F ',' '{if($9 == access_type){print $1, $14}}' /tmp/block_trace_human_file  >  $caller_log
    # get total cache hit  rate 

    awk 'BEGIN{total =0 ; hit_count=0;}{total+=1 ; if($14 == 1){hit_count +=1;}} END{print hit_count/total}' $caller_log > /tmp/compact_block_trace/block_cache_total_hit_rate_${branch}_${block_size}_${i}
    # plot 
  ./block_cache_get_hit_rate_change_dur.sh $caller_log $block_size $i
  done


done 
done 
