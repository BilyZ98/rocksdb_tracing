

This folder includes scripts to generate block cache trace info
for compaction usage only.

The python script is used to record the timeline of the block that is 
accessed in the block and then removed gradually.

The workflow should be 


../ycsb_trace/evict_block_analyze.sh 
&&  ./get_compact_block_trace.sh
&& python ./compact_block_trace.py



