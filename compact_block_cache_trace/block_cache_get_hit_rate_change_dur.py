



import sys


in_file = sys.argv[1]

out_file = sys.argv[2]

# or maybe just use line count 

dur_line_count = 1000

in_f = open(in_file,'r')
out_f = open(out_file, 'w')

cur_count = 0;
total_hit = 0
for  line in in_f:
    fields = line.split()
    time = fields[0] 
    is_hit = fields[1]
    cur_count += 1
    if  is_hit == '1':
        total_hit += 1
    if cur_count % dur_line_count == 0:
        out_f.write("%s %f\n" %(time, total_hit/dur_line_count))
        cur_count = 0
        total_hit = 0


in_f.close()
out_f.close()
