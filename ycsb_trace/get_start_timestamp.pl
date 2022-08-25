#!/usr/bin/perl


$op_file = $ARGV[0] ? $ARGV[0] : "/tmp/trace_data_dir/op_trace-human_readable_trace.txt";
$block_human_file =$ARGV[1] ? $ARGV[1] : "/tmp/trace_data_dir/block_trace_human_file";
$io_human_file = $ARGV[2] ?  $ARGV[2] : "/tmp/trace_data_dir/io_trace_res";



$op_start_time = system("head -n1 $op_file \| awk '{print $5}'");

$block_start_time = system("head -n1 $block_human_file \| awk -F ',' '{print $1}'");

$io_start_time = system("head -n1 $io_human_file \| awk '{print $2}'");


# $op_start_time = @ops[4];
# $block_start_time = @bocks[0];
# $io_start_time = @ios[2];


print "op : $op_start_time \n  block: $block_start_time \n io: $io_start_time\n";














