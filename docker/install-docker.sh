#!/bin/bash

# install bityuan node
docker pull bityuan/node:latest
docker run -d --name "bty" -p 13802:13802 -v /data:/data --restart always bityuan/node:latest

for((i=1;i<=30;i++));  
do
    num=$(docker ps -a | grep '\bbty\b' |grep -F '13802'|wc -l)
    echo "bty num:" $num
    if [ $num -eq 1 ]; then
    	break
    fi
    sleep 1s
done 

for((i=1;i<=30;i++));
do
    peersNum=$(docker exec -it bty chain33-cli net peer_info | grep addr | wc -l)
    if [ $peersNum -gt 1 ]; then
    	echo "peersNum:" $peersNum
        break
    fi
    sleep 1s
done

docker exec -it bty chain33-cli net info

seed=$(docker exec -it bty chain33-cli seed generate -l 0 | grep seed | cut -d '"' -f 4)
seed=\"$seed\"
echo "seed:$seed"
docker exec -it bty /bin/bash -c "chain33-cli seed save -p 123456 -s $seed"
docker exec -it bty chain33-cli wallet unlock -p 123456 -s wallet -t 0

for((i=1;i<=30;i++));
do
    num=$(docker exec -it bty chain33-cli account  list  | grep "node award" | wc -l)
    echo "addr num:" $num
    if [ $num -gt 0 ]; then 
    	node=$(docker exec -it bty chain33-cli account  list  | grep "node award" -B 2 | grep addr | cut -d '"' -f 4)
	echo $node
	break
    fi
    sleep 1s
done

#echo $node
priv=$(docker exec -it bty chain33-cli  account dump_key -a $node | grep replystr | cut -d '"' -f 4)
#echo $priv
echo "Run the cmd in wallet PC: account import_key -l ali00001 -k $priv"

