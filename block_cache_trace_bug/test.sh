exec_path="../build/db_bench"


db_path="/mnt/pmem/block_cache_trace"
$exec_path   --benchmarks="fillseq" --db=$db_path \
--key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
--cache_index_and_filter_blocks --cache_size=1048576 \
--disable_auto_compactions=1 --disable_wal=1  \
--min_level_to_compress=-1  --num=10000000

$exec_path --benchmarks="readrandom" --use_existing_db --db=$db_path --duration=60 \
--key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
--cache_index_and_filter_blocks --cache_size=1048576 \
--disable_auto_compactions=1 --disable_wal=1 \
--min_level_to_compress=-1  --num=10000000 \
--threads=16 \
-block_cache_trace_file="/tmp/binary_trace_test_example" \
-block_cache_trace_max_trace_file_size_in_bytes=1073741824 \
-block_cache_trace_sampling_frequency=1

bct_path="../build/block_cache_trace_analyzer_tool"
$bct_path \
-block_cache_trace_path=/tmp/binary_trace_test_example \
-human_readable_trace_file_path=/tmp/human_readable_block_trace_test_example
