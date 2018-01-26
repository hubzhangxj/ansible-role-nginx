#!/bin/sh

source scripts/profile

ulimit -n 102400

target=${1-"localhost"}

threads=8
#threads=4
#threads=1
#threads=64
(( connections=threads*4 ))
#(( connections=threads*1 ))
#(( connections=threads*16 ))
#(( requests=connections*1 ))
(( requests=connections*400000 ))
#(( requests=connections*4000 ))

url=http://${target}/index.html

httpress -n $requests -c $connections -t $threads $url
#httpress -n 200000 -c 100 -t 64 -k http://192.168.1.188/index.html
