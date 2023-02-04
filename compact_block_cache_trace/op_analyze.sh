pushd ../build
./trace_analyzer \
  -analyze_get \
  -output_access_count_stats \
  -output_dir=/tmp/op_analyze/ \
  -output_key_stats \
  -output_qps_stats \
  -output_value_distribution \
  -output_key_distribution \
  -print_overall_stats \
  -print_top_k_access=3 \
  -output_prefix=test \
  -trace_path=/tmp/op_trace_file


popd

  # -convert_to_human_readable_trace \
