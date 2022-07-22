#!/bin/bash



EXEC=../trace_analyzer
$EXEC -analyze_get -analyze_put -analyze_merge -analyze_delete \
-analyze_single_delete -analyze_iterator -analyze_multiget \
-output_access_count_stats -output_dir=/tmp/trace_dir -output_key_stats -output_qps_stats \
-output_value_distribution -output_key_distribution -output_time_series -print_overall_stats \
-convert_to_human_readable_trace  \
-print_top_k_access=3 -value_interval=1 -output_prefix=trace_test -trace_path=/tmp/trace_test_example \




