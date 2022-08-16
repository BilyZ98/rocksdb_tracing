

ycsb_exec="../build/ycsb_run"



db_path="/mnt/pmem/ycsb_trace"
rm -rf $db_path
load_path=${1:-../ycsb-workload-gen/ycsb_data/workloada-load-1000000-10000000.log.formated}
run_path=${2:-../ycsb-workload-gen/ycsb_data/workloada-run-1000000-10000000.log.formated}

trace_path="/tmp/trace_file"
block_cache_trace_path="/tmp/block_cache_trace_file"
io_trace_path="/tmp/io_trace_file"

$ycsb_exec -db=$db_path -load_file=$load_path -run_file=$run_path \
  -trace_file=$trace_path -block_cache_trace_file=$block_cache_trace_path \
  -ycsb_io_trace_file=$io_trace_path



