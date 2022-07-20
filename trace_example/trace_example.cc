
#include "rocksdb/db.h"
#include "rocksdb/trace_record.h"
#include  "rocksdb/trace_reader_writer.h"
#include <string>
#include <iostream>

#include <memory>

using namespace rocksdb;

int main() {
  Env* env = rocksdb::Env::Default();
  EnvOptions env_options;
  std::string trace_path = "/tmp/binary_trace_test_example"; 
  // so why unique_ptr?
  std::unique_ptr<TraceWriter> trace_writer;

  std::string db_name = "/tmp/rocksdb_trace";
  NewFileTraceWriter(env, env_options , trace_path, &trace_writer);

  Options options;
  // options.create_if_missing = true;
  DB* db;
  Status s  = DB::Open(options, db_name, &db);
  if(!s.ok()) {
    std::cout << "open failed\n" << s.ToString();
    return 0;
  }
  TraceOptions to;
  db->StartIOTrace(to, std::move(trace_writer));

  WriteOptions write_options;
  db->Put(write_options,"hello there", "madan");
  

  db->EndIOTrace();


  return 0;
}
