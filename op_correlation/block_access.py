

in_file_name = "/tmp/block_trace_human_file"

blocks = {}



in_file = open(in_file_name, 'r')


for line in in_file:
    s_line = line.split(",")
    block_id = s_line[1]
    if block_id not in blocks:
        blocks[block_id] = {}

    op_type = s_line[8]
    if op_type not in blocks[block_id]:
        blocks[block_id][op_type] = 0

    is_hit = s_line[13] == '1'    
    count = 0
    if is_hit:
        count = 1

    blocks[block_id][op_type]+= count


in_file.close()


out_file_name = "/data/zhutao/block_count.txt"
out_file = open(out_file_name, 'w')
for k, v in blocks.items():
    get_count = v.get('1', 0)
    iter_count = v.get('3', 0)
    compact_count = v.get('10', 0)
    res = 0
    if get_count != 0 : 
        res = float(iter_count / get_count)
    out_file.write("%s %f\n" % (k , (res) ))

out_file.close()

































