

Discussion with zhichao this week helps me know more about the motivation of this project.

He wants me to run the myrocks with complex upper level benchmark instead of db_bench which is more predictable.

The intent for this move is that we want to discover some pattern or correlation between upper level query and lower level key-value database operation and IO operation so that we may be get some hint or inspiration of how to  allocate our resource or do some extra optimization with the upper level query info.


Good motivation !!!

Let's do it.
