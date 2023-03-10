


 # ../build/db_bench  --block_size=16384 --compression_type=none -mix_get_ratio=0.1 -mix_seek_ratio=0.1 -mix_put_ratio=0.8  --benchmarks=mixgraph -num=20000000 -readwritepercent=50 -cache_size=104857600
 # 
 ../build/db_bench   --compression_type=none -mix_get_ratio=0.15 -mix_seek_ratio=0.15 \
   -mix_put_ratio=0.7  --benchmarks=mixgraph -num=200000000 --db=/mnt/nvme0n1/rdb_test \
   -cache_size=1048576000
 ../compact_block_cache_trace/evict_block_analyze.sh 
