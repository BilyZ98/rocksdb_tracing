

#include "rocksdb/db.h"  
#include "rocksdb/trace_reader_writer.h"

#include <memory>
#include <string>
#include <iostream>


using namespace rocksdb;
int main() {
  Options opt;
  Env* env = Env::Default();
  EnvOptions env_optios(opt);

  std::string trace_path = "/tmp/trace_test_example";

  std::unique_ptr<TraceWriter> trace_writer;
  DB* db = nullptr;
  std::string db_name = "/tmp/rocksdb";

  opt.create_if_missing = true;
  NewFileTraceWriter(env, env_optios, trace_path, &trace_writer);
  Status s;
  s = DB::Open(opt, db_name, &db);
  if(!s.ok()) {
    std::cout << s.ToString() <<  std::endl;
    return 0;
  }

  TraceOptions trace_opt;
  // why do we use std::move here ?
  db->StartTrace(trace_opt, std::move(trace_writer));

  WriteOptions write_opt;
  db->Put(write_opt, "test1", "testvalue");
  db->Put(write_opt, "yo", " hello there sdsd ");

  db->EndTrace();

  return 0;

}
