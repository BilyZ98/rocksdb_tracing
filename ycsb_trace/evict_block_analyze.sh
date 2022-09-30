
block_trace_tool="/home/bily/rocksdb_tracing/build/block_cache_trace_analyzer_tool"

gdb --args  $block_trace_tool \
  --block_cache_trace_path=/tmp/block_cache_trace_file \
  --human_readable_trace_file_path=/tmp/block_trace_human_file \
  --evict_block_cache_trace_path=/tmp/evict_block_cache_trace_file \
  --evict_human_readable_trace_file_path=/tmp/evict_block_human_file
