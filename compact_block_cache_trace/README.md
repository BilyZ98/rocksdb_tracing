

This folder includes scripts to generate block cache trace info
for compaction usage only.

The python script is used to record the timeline of the block that is 
accessed in the block and then removed gradually.

The workflow should be 


../ycsb_trace/evict_block_analyze.sh 
&&  ./get_compact_block_trace.sh
&& python ./compact_block_trace.py
&& ./block_cache_get_hit_rate.sh


block_cache_get_hit_rate.py will receive block cache access for different caller(get, compaction, iterator) and then output cache hit rate file .

## block cache hit rate data extraction

call ./evict_block_analyze.sh before calling ./block_cache_get_hit_rate_change_dur.sh to get the block cache trace human data file 

./block_cache_get_hit_rate_change_dur.sh calls ./block_cache_get_hit_rate_change_dur.py file 

./block_cache_get_hit_rate_change_dur.py
will receive block cache access file and then output cache hit rate in some duration(1s, 100ms )


To call the ./block_cache_get_hit_rate_change_dur.sh you need to extract the cache hit rate for get and/or compaction  with the following command 
```
awk  -F ',' '{print $1, $14}' /tmp/block_trace_human_file  > /tmp/compact_block_trace/block_cache_get_and_compact

```
## block cache trace data access for standard rocksdb 


Command to get block cache trace information with hit rate control:
```

./db_bench --compression_type=none --benchmarks=readrandomwriterandom -num=20000000 -readwritepercent=50 -cache_size=104857600
```



