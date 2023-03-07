

in_file_name = "/tmp/block_trace_human_file"

iters = {}



in_file = open(in_file_name, 'r')


for line in in_file:
    line = line.strip()
    s_line = line.split(",")
    iter_id = s_line[21]
    if iter_id not in iters:
        iters[iter_id] = {'hit_count': 0, 
                           'access_count': 0,
                          'sst': set(),
                          'blocks':set(),
                          'level': set()
                          }



    is_hit = s_line[13]  == '1'
    hit_count = 0
    if is_hit:
        hit_count =1

    sst_id = s_line[7]
    level = s_line[6]
    block_id = s_line[1]

    iters[iter_id]['hit_count'] += hit_count
    iters[iter_id]['access_count'] += 1
    iters[iter_id]['sst'].add(sst_id)
    iters[iter_id]['blocks'].add(block_id)
    iters[iter_id]['level'].add(level)

in_file.close()

out_name = '/data/zhutao/iter_count.txt'

total_hit = 0
total_access = 0
total_sst = 0
total_blocks = 0
total_level = 0
out_file = open(out_name, 'w')
for k, v in iters.items():
    ratio = 0
    access_count = v['access_count']
    hit_count = v['hit_count']
    sst_size = len(v['sst'])
    blocks_count = len(v['blocks'])
    level_count = len(v['level'])
    total_hit += hit_count
    total_access += access_count
    total_sst += sst_size
    total_blocks += blocks_count
    total_level += level_count
    ratio = float(hit_count / access_count)
    w_line = "{} {} {} {} {} {} {}\n".format(k, ratio, sst_size, blocks_count, level_count, hit_count, access_count)
    out_file.write(w_line)
    # out_file.write('%s %f %d %d %d \r\n' % (k, ratio, sst_size, blocks_count, level_count))

out_file.close()

total_iter = len(iters)
print("access:{} \nhit:{} \nsst:{}\nblocks:{}\nlevels:{}\n", total_access/total_iter, total_hit/total_iter, total_sst/total_iter, total_blocks/total_iter, total_level/total_iter)
