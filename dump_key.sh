#!/bin/bash

cd ~/chain33
./chain33-cli  wallet unlock  -p 123456 -s wallet -t 0

for i in $(seq 30)
do
    num=$(./chain33-cli account  list  | grep "node award" -c)
    echo "addr num: $num"
    if [ "$num" -gt 0 ]; then 
    	node=$(./chain33-cli account  list  | grep "node award" -B 2 | grep addr | cut -d '"' -f 4)
	echo "$node"
	break
    fi
    sleep 1s
done

#echo $node
priv=$(./chain33-cli  account dump_key -a "$node" | grep replystr | cut -d '"' -f 4)
#echo $priv
echo "Run the cmd in wallet PC: account import_key -l ali00001 -k $priv"

