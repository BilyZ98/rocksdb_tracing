

#include "gflags/gflags.h"
#include "rocksdb/db.h"
#include "rocksdb/env.h"
#include "rocksdb/options.h"
#include "rocksdb/trace_reader_writer.h"
//##include "hashBenchmark.hpp"
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <fstream>
#include <iostream>

typedef enum OP_TYPE {
  READ,
  INSERT,
  UPDATE,
  DELETE,
  SCAN,
  READMODIFYWRITE,
  UNKNOWN
} op_type_t;




op_type_t get_op_type(const std::string& s) {
  if(s == "READ") {
    return READ;
  }  else if(s == "INSERT") {
    return INSERT;

  } else if(s == "UPDATE") {
    return UPDATE;

  } else if(s == "DELETE") {
    return DELETE;

  } else if (s == "SCAN") {
    return SCAN;

  } else if(s  == "READMODIFYWRITE") {
    return READMODIFYWRITE;

  }

  return UNKNOWN;
} 

DEFINE_string(load_file, "", "load file name");
DEFINE_string(run_file, "", "run file name");
DEFINE_string(db, "/tmp/rocksdb_trace", "db path");
DEFINE_string(trace_file, "", "op trace file");
DEFINE_string(block_cache_trace_file, "", "block cache trace file");
DEFINE_string(ycsb_io_trace_file, "", "io trace file");


int main(int argc, char* argv[]) {
  printf("hello there\n");
  // read all the data from ycsb data file

  gflags::ParseCommandLineFlags(&argc, &argv,true );

  uint64_t hash_key;
  std::string op_string;
  uint64_t key_nums_load = 0;
  uint64_t key_nums_run = 0;

  rocksdb::DB *db =nullptr;
  rocksdb::Options options;
  options.create_if_missing = true;
  auto s =  rocksdb::DB::Open(options, FLAGS_db, &db);
  if(!s.ok()) {
    std::cerr << "open db failed: " << s.ToString() << std::endl;
    return -1; 

  }

  rocksdb::WriteOptions write_options;
  // load phase
  std::string val_str(100, 'a');
  for(size_t i=0; i < val_str.length(); i++ ) {
    val_str[i] = (i + 'a') % 26;
  }
  rocksdb::Slice val(val_str);

  {
    std::vector<op_type_t> load_ops;
    std::vector<uint64_t> load_keys;
    std::ifstream load_file_stream(FLAGS_load_file);
    while(load_file_stream >> op_string >> hash_key) {
      load_ops.push_back(get_op_type(op_string));
      load_keys.push_back(hash_key);

    }
    std::cout << "size of load" << load_ops.size() << std::endl;

    for(size_t i=0; i < load_ops.size(); i++) {
      rocksdb::Slice key((char*)&load_ops[i], sizeof(uint64_t));
      db->Put(write_options, key, val);
    }


  }
 

  std::ifstream run_file_stream(FLAGS_run_file);
  std::vector<op_type_t> run_ops;
  std::vector<uint64_t> run_keys;
  while(run_file_stream >> op_string >> hash_key) {
    run_ops.push_back(get_op_type(op_string));
  }



  // run phase 
  rocksdb::TraceOptions trace_options;
  rocksdb::TraceOptions block_cache_trac_options;
  rocksdb::TraceOptions io_trace_options;

  rocksdb::Env * env = rocksdb::Env::Default();
  if(FLAGS_trace_file  != "" ) {
    std::unique_ptr<rocksdb::TraceWriter> trace_writer;
    s = rocksdb::NewFileTraceWriter(env, rocksdb::EnvOptions(), 
       FLAGS_trace_file, &trace_writer);
    if(!s.ok()) {
      fprintf(stderr, "Encountered an error starting a trace, %s\n" , s.ToString().c_str());
      return 1;
    }
    s = db->StartTrace(trace_options, std::move(trace_writer));
    if(!s.ok()) {
      fprintf(stderr, "Encountered an error starting a trace %s\n", 
          s.ToString().c_str());
      return 1;
    }

    fprintf(stdout, "Tracing the workload to [%s]\n", FLAGS_trace_file.c_str());


  }

  if(FLAGS_block_cache_trace_file != "") {
    std::unique_ptr<rocksdb::TraceWriter> trace_writer;
    s = rocksdb::NewFileTraceWriter(env, rocksdb::EnvOptions(), 
        FLAGS_block_cache_trace_file, &trace_writer);
    if(!s.ok()) {
      fprintf(stderr, "Error encoutnered starting block cache trace, %s\n",
          s.ToString().c_str());
    }
    s = db->StartBlockCacheTrace(block_cache_trac_options, std::move(trace_writer));
    if(!s.ok()) {
      fprintf(stderr, "Error encoutnered starting block cache trace, %s\n",
          s.ToString().c_str());
    }
    fprintf(stdout, "block cache trace workload to [%s]\n",
        FLAGS_block_cache_trace_file.c_str());

  }


  if(FLAGS_ycsb_io_trace_file != "") {
    std::unique_ptr<rocksdb::TraceWriter> trace_writer;
    s = rocksdb::NewFileTraceWriter(env, rocksdb::EnvOptions(), 
        FLAGS_ycsb_io_trace_file , &trace_writer);

    if(!s.ok()) {
     fprintf(stderr, "Error encountered at starting io trace %s\n",
        s.ToString().c_str());
     return 1;
     
    }
    s = db->StartIOTrace(io_trace_options, std::move(trace_writer));

    if(!s.ok())  {
      fprintf(stderr, "Error encountered at starting io trace %s\n",
          s.ToString().c_str());
      return 1;
    }
    fprintf(stdout, "writing io trace data to [%s]\n",
        FLAGS_ycsb_io_trace_file.c_str());
  }


  
  
  
  return 0;
}
