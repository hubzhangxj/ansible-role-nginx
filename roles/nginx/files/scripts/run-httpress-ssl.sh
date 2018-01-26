
#!/bin/sh

source scripts/profile

ulimit -n 102400

target=${1-"localhost"}

threads=1
#threads=64

#(( connections=threads*32 ))
(( connections=threads*1 ))
#(( connections=threads*16 ))
#(( connections=threads*8 ))

(( requests=connections*4000 ))
#(( requests=connections*400 ))

url=https://${target}/index.html

httpress -n $requests -c $connections -t $threads $url
#httpress -n 200000 -c 100 -t 64 -k https://192.168.1.188/index.html
