

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



./block_cache_get_hit_rate_change_dur.py
will receive block cache access file and then output cache hit rate in some duration(1s, 100ms )




