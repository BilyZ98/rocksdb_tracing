#!/bin/perl

$op_file = "/tmp/trace_data_dir/op_trace-human_readable_trace.txt";


$out_file = "/tmp/trace_data_dir/op_trace_human_keys_remap.txt";



@keys = `head -n10 $op_file | awk '{print $1}' `;

chomp @keys;


foreach $key (@keys) {
  @fields = split(" ", $key);
  print "@fields[0] \n";
}


$arr_size = @keys;  
print "arr size is $arr_size \n";

$cnt = 1;


my %hash = ();

# check hash exists
# https://stackoverflow.com/questions/1003632/how-can-i-see-if-a-perl-hash-already-has-a-certain-key
if(exists $hash{"test"}) {
  print " hello exists\n";
} else {
  print "not exists\n";
}


foreach $key (@keys) {
  @fields = split(" ", $key);
  $key = @fields[0];
  if(!exists $hash{$key}) {
    $hash{$key} = $cnt++;
  }
}


for my $key (keys %hash) {
  print "$key : $hash{$key}\n";
}

$hash_size = keys %hash;
print "hash size is $hash_size\n";

my @label_ids ;

foreach $key(@keys) {
  @fields = split(" ", $key);
  $key = @fields[0];
  $key_id = $hash{$key};
  print "$key: $key_id\n";
}
















