while [[ $# -gt 0 ]]; do
  case $1 in 
    --disable_bcp)
      disable_bcp=1
      shift
      shift
      ;;
  esac
done




exec_path="../build/db_bench"


db_path="/mnt/pmem/block_cache_trace"
$exec_path   --benchmarks="fillseq" --db=$db_path \
--key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
--cache_index_and_filter_blocks --cache_size=1048576 \
--disable_auto_compactions=1 --disable_wal=1  \
--min_level_to_compress=-1  --num=100000


trace_data_dir="./trace_data_dir"
rm -rf "$trace_data_dir"
if [ ! -e $trace_data_dir ]; then 
  mkdir -p $trace_data_dir
fi

block_trace_file_path="$trace_data_dir/block_cache_trace_file"
op_trace_file_path="$trace_data_dir/op_trace_file"
io_trace_file_path="$trace_data_dir/io_trace_file"

$exec_path --benchmarks="readrandom" --use_existing_db --db=$db_path --duration=60 \
--key_size=20 --prefix_size=20 --keys_per_prefix=0 --value_size=100 \
--cache_index_and_filter_blocks --cache_size=1048576 \
--disable_auto_compactions=1 --disable_wal=1 \
--min_level_to_compress=-1  --num=100000 \
--threads=16 \
-block_cache_trace_file="$block_trace_file_path" \
-block_cache_trace_max_trace_file_size_in_bytes=1073741824 \
-block_cache_trace_sampling_frequency=1 \
-trace_file="$op_trace_file_path" \
-bench_io_trace_file="$io_trace_file_path"



if [ -z $disable_bcp ]; then
bct_path="../build/block_cache_trace_analyzer_tool"
block_cache_trace_human_file="$trace_data_dir/block_cache_trace_human_file"
$bct_path \
-block_cache_trace_path="$block_trace_file_path" \
-human_readable_trace_file_path="$block_cache_trace_human_file"
fi


trace_analyzer_exec="../build/trace_analyzer"
$trace_analyzer_exec \
  -analyze_get \
  -output_access_count_stats \
  -output_dir="$trace_data_dir" \
  -output_key_stats \
  -output_qps_stats \
  -convert_to_human_readable_trace \
  -output_value_distribution \
  -output_key_distribution \
  -print_overall_stats \
  -print_top_k_access=3 \
  -output_prefix=op_trace \
  -output_time_series \
  -trace_path="$op_trace_file_path"


io_trace_parser_exec="../build/io_tracer_parser"
io_parser_res="$trace_data_dir/io_trace_res.log"
$io_trace_parser_exec \
  -io_trace_file="$io_trace_file_path" >  "$io_parser_res"

