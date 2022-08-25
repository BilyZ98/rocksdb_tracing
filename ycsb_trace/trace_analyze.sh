#!/bin/bash


op_trace_file_path=$1
block_trace_file_path=$2
io_trace_file_path=$3

data_dir="/tmp/trace_data_dir"

rm -rf $data_dir
mkdir -p $data_dir

trace_analyzer="/home/bily/rocksdb_tracing/build/trace_analyzer"
$trace_analyzer \
  -analyze_get \
  -output_access_count_stats \
  -output_dir="$data_dir" \
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

block_cache_trace_analyzer="/home/bily/rocksdb_tracing/build/block_cache_trace_analyzer_tool"
bct_human_file_path="$data_dir/block_trace_human_file"
$block_cache_trace_analyzer \
 -block_cache_trace_path="$block_trace_file_path"\
 -human_readable_trace_file_path="$bct_human_file_path"

io_trace_parser_exec="/home/bily/rocksdb_tracing/build/io_tracer_parser"
io_parser_res="$data_dir/io_trace_res"
$io_trace_parser_exec -io_trace_file="$io_trace_file_path" >  "$io_parser_res"


./get_time.sh
