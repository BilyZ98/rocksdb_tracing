

block_trace_file="./trace_data_dir/block_cache_trace_file"
../build/block_cache_trace_analyzer_tool \
-block_cache_trace_path="$block_trace_file" \
-block_cache_analysis_result_dir=/tmp/sim_results/test_trace_results \
-print_block_size_stats \
-print_access_count_stats \
-print_data_block_access_count_stats \
-timeline_labels=cf,level,bt,caller \
-analyze_callers=Get,Iterator,Compaction \
-access_count_buckets=1,2,3,4,5,6,7,8,9,10,100,10000,100000,1000000 \
-analyze_bottom_k_access_count_blocks=10 \
-analyze_top_k_access_count_blocks=10 \
-reuse_lifetime_labels=cf,level,bt \
-reuse_lifetime_buckets=1,10,100,1000,10000,100000,1000000 \
-reuse_interval_labels=cf,level,bt,caller \
-reuse_interval_buckets=1,10,100,1000,10000,100000,1000000 \
-analyze_blocks_reuse_k_reuse_window=3600 \
-analyze_get_spatial_locality_labels=cf,level,all \
-analyze_get_spatial_locality_buckets=10,20,30,40,50,60,70,80,90,100,101 \
-analyze_correlation_coefficients_labels=all,cf,level,bt,caller \
-skew_labels=block,bt,table,sst,cf,level \
-skew_buckets=10,20,30,40,50,60,70,80,90,100
