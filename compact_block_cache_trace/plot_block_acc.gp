

set output "/tmp/block_access.png"
set terminal png size 800,400

#plot "/tmp/trace1" using 1:5 smooth bezier w lines
#plot "/tmp/trace1" using 1:3  smooth bezier  w lines, \
#"/tmp/trace1" using 1:4  smooth bezier  w lines

set yrange[-1:2]
plot       "/tmp/trace10" using 1:3 smooth bezier w lines, \
"/tmp/trace10" using 1:4 smooth bezier w lines
#set yrange [-1:1.1]
#plot "/tmp/trace10" using 1:5 smooth bezier  w lines 

#plot "/tmp/trace3" using 1:5 smooth bezier w lines 
#set yrange [-1:300]
#plot "/tmp/trace3" using 1:3 smooth bezier w lines, \
#"/tmp/trace3" using 1:4 smooth bezier w lines 

