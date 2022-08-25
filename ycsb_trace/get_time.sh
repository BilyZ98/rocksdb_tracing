#!/bin/bash


op_file="/tmp/trace_data_dir/op_trace-human_readable_trace.txt"

block_file="/tmp/trace_data_dir/block_trace_human_file"

io_file="/tmp/trace_data_dir/io_trace_res"


op_start=`head -n1 $op_file | awk '{print $5}' `

block_start=`head -n1 $block_file | awk -F ',' '{print $1}'`

io_start=`head -n1 $io_file | awk '{print $3}'`




echo "op:"$op_start 
echo "block:" $block_start
echo "io:" $io_start


start_time=`printf "$op_start\n$io_start\n$block_start" \
  | sort -n | head -n1`

echo $start_time



io_timestamps=`cut -d  ' ' -f 4-4 $io_file  \
  | tail -n+4 | cut -c-16 

  # | awk -v stime="$io_start" \
  # '{print $1 + stime}' | `


file_type=`tail -n+4 $io_file | awk -F ',' \
  '{if ($3 ~ /Append/) {print 1} \
  else if($3 ~ /Close/) {print 2} \
  else if($3 ~ /DeleteFile/) {print 3} \
  else if($3 ~ /GetFileSize/) {print 4} \
  else if($3 ~ /NewDirectory/) {print 5} \
  else if($3 ~ /NewRandomAccessFile/) {print 6} \
  else if($3 ~ /NewSequentialFile/) {print 7} \
  else if($3 ~ /NewWritableFile/)  {print 8}\
  else if($3 ~ /Prefetch/)  {print 9}\
  else if($3 ~ /Read/) {print 10} \
  else if($3 ~ /ReopenWritableFile,/ ) {print 11} \
  else {print 12}
  }'`

# printf "$file_type\n"
echo "$file_type" | wc -l

line_io_timestamps=`echo "$io_timestamps" | wc -l`
line_io_file=`tail -n+4 $io_file | wc -l`

printf "$line_io_timestamps $line_io_file \n "

paste_io=`paste  <(echo "$io_timestamps")   \
  <(echo "$file_type") <(tail -n+4 $io_file) `


res_io_file="/tmp/trace_data_dir/abs_time_io_trace_res"
echo "$paste_io" >   $res_io_file



































