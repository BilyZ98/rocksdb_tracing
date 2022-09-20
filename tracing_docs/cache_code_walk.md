

include/rocksdb/cache.h
```
  Class Cache {
      Insert(Slice key, );

      Handle* Lookup(Slice key,);

    }

```



db_impl.cc 
```
DBImpl() {

  table_cache_  =  NewLRUCache(co)
}
```

cache/lru_cache.cc
```

// cache insert and lookup
class ShardedCache: public Cache {


virtual Status Insert(const Slice& key, void * value) 


virtual Handle* Lookup(const Slice&key, Statistics* stats) 

private:
  LRUCacheShard* shards_ =  nullptr;
}



Class LRUCache : public ShardedCache {

  LRUCache(size_t capacity, int num_shard_bits) {

  }
}



std::shared_ptr<Cache> NewLRUCache() {
  return std::make_shared<LRUCache>(capacity, num_shard_bits, ... , std::move(memory_allocator))

}

LRUHandle* LRUHandleTable::Insert(LRUHandle* h) {

}




class LRUCacheShard: public CacheShard {

virtual Status Insert(const Slice&key);

virtual Cache::Handle* Lookup(const Slice&key);
}


LRUHandle* LRUHandleTable::Remove(const Slice&key, uint32_t hash) {

}
```

cache/sharded_cache.h
```
// my understanding is that this is the class that actually
// stores the data
class CacheShard {
  virtual Status Insert();

  virtual Cache::Handle* Lookup(const Slice&key);
}


Status LRUCacheShard::Insert(const Slice&key) {
  return InsertItem(e, handle,)
}


// what is the difference between LRUHandle and 
// Cache::Handle
Status LRUCacheShard::InsertItem(LRUHandle* e, Cache::Handle) {

}

```


table/block_based/block_based_table_reader.cc
```

Version->Get()
  table_cache_->Get()
    FindTable
    t = GetTableReaderFromHandle()
    // block_cache_ is stored in rep_->table_options
    // I know it, BlockBasedTabke have to get block from 
    // the block cache.
    // BlockBasedTable is a class that provide interface like
    // get and iterator to the users and 
    // hide cache detail  from user.
    t->Get(k, get_context)
    
    // BlockBasedTable->Get
      // this call is for Get() and MultiGet()
      WriteBlockAccess()
      NewDataBlockIterator()
        RetrieveBlock()


    
BlockBasedTable::RetrieveBlock()
  Status BlockBasedTable::MaybeReadBlockAndLoadToCache() {
    GetDataBlockFromCache(key, block_cache)
    // key = block_key, the key that is accessed in this block.
    block_cache_tracer_->WriteBlockAccess(access_record, key);
  


    BlockCacheTraceAnalyzer::RecordAccess()
      BlockCacheHumanReadableTraceWriter::WriteHumanReadableTraceRecord(uint64 block_id)
// block_id is self owned variable by BlockCacheTraceAnalyzer
// the block id is generated during the off-line analyze phase.

// curious why block_id will be increased for each new key.
// What if there are some keys that were accessed before but move to another block due to the compaction ?
// Figure out how this work
// The block id is determined from the tree structure.
  
```


tools/block_cache_analyzer/block_cache_trace_analyzer.cc
```
BlockCacheTraceAnalyzer::RecordAccess(BlockCacheTraceRecord& access) {
  unique_block_id_++;

}
```


But I don't have any access info for the table_->Remove()



