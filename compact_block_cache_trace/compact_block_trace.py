




compact_block_file_name = "/tmp/compact_block_trace/compact_block_trace_file"



compact_block_file = open(compact_block_file_name, 'r')
lines = compact_block_file.readlines()

print(len(lines))


compact_block_time_dict = {}

compact_blocks = []

for line in lines:
    # print(line)
    fields = line.split(',')
    block_id = fields[1]
    time = int(fields[0])
    compact_block_time_dict[block_id] =  time
    compact_blocks.append((time, 0))

print("compact block cache hit count {}" , len(lines))

evict_file_name = "/tmp/evict_block_human_file"

evict_file = open(evict_file_name, 'r')
# evict_lines = evict_file.readlines()


# print(len(evict_lines))


evict_count = 0
miss_count = 0

accessed = {}
late_count = 0
for evict_line in evict_file:
    fields = evict_line.split(',')
    block_id = fields[1]
    time = int(fields[0])
    if block_id in compact_block_time_dict:
        # print("block id: {}, cur time {}, orig time {}".format(block_id, time, compact_block_time_dict[block_id]))
        orig_time = int(compact_block_time_dict[block_id])
        if time > orig_time: 
            late_count += 1
        evict_count += 1
        # compact_blocks.append((time, 1))
        # if block_id in accessed:
        #     print("{} already visited, orig time {}, cur time {} ".format(block_id, compact_block_time_dict[block_id], time))
        accessed[block_id] = time
    else:
        miss_count += 1

print("evict count %d, miss count %d, compact block count: %d" % (evict_count, miss_count,len(lines)))
print("access len: {}".format(len(accessed)))

print("late count {}".format(late_count))


duration_file_name = "/tmp/compact_block_trace/block_duration.txt"
dur_file = open(duration_file_name, 'w')

for block_id in compact_block_time_dict: 
    orig_time = compact_block_time_dict[block_id]
    if block_id in accessed:
        evict_time = accessed[block_id]
        delta = int(evict_time) - int(orig_time)
        dur_file.write("%d\n" % (delta))

dur_file.close()
    

        


    
in_cache_count = 0

for block_id in accessed:
    time = accessed[block_id]
    compact_blocks.append((time, 1 ))

compact_blocks.sort()
# print(compact_blocks)
# sorter = lambda x: (x[0], x[1])
# sorted_compact_blocks = sorted(compact_blocks,  key=sorter)
in_cache_num = []
cur_count = 0
for time_evict_tupe  in compact_blocks:
    time = time_evict_tupe[0]
    evict = time_evict_tupe[1]
    if evict == 0:
        cur_count += 1
    else:
        cur_count -= 1
    in_cache_num.append((time, cur_count))





f = open('/tmp/compact_block_trace/evict_block_time', 'w')
for pair in in_cache_num:
    f.write("%s %d \n" % (pair[0], pair[1]))

f.close()

# print(sorted_compact_blocks)
# sort(compact_blocks)
# print("len of results is %d" % len(sorted_compact_blocks))


