

ycsb_exec="../build/ycsb_run"



db_path="/tmp/db_dir"
load_path="../ycsb-workload-gen/ycsb_data/workloada-load-100-100.log.formated"
run_path="../ycsb-workload-gen/ycsb_data/workloada-run-100-100.log.formated"

trace_path="/tmp/trace_file"
block_cache_trace_path="/tmp/block_cache_trace_file"
io_trace_path="/tmp/io_trace_file"

$ycsb_exec -db=$db_path -load_file=$load_path -run_file=$run_path \
  -trace_file=$trace_path -block_cache_trace_file=$block_cache_trace_path \
  -ycsb_io_trace_file=$io_trace_path



