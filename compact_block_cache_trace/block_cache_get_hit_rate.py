

import sys
# print("arg[0]: {}".format(sys.argv[1]))

# exit;


block_cache_get_file =  sys.argv[1]
# '/tmp/compact_block_trace/block_cache_compaction']

out_file = sys.argv[2]
print("out file is {}".format(out_file))
# '/tmp/compact_block_trace/block_cache_compaction_hit_rate_change.txt']

f = open(block_cache_get_file, 'r')
out_f = open(out_file, 'w')

hit = 0
total = 0

for line in f:
    fields = line.split()
    # print("len is {}".format(len(fields)))
    time = fields[0]
    is_hit = fields[1] 
    total += 1
    # print(is_hit)
    if is_hit == '1':
        hit += 1
    out_f.write('%s %f\n' %(time, hit/total))

print("hit is {}".format(hit))
out_f.close()


f.close()

