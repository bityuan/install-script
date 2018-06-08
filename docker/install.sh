#!/bin/bash
set -e

# install docker
curl -fsSL https://get.daocloud.io/docker | sh

# create script to run chain33-cli
echo "#!/bin/bash" > /usr/local/bin/chain33-cli
echo "set -x" > /usr/local/bin/chain33-cli
echo 'docker exec -it bty chain33-cli $*' >> /usr/local/bin/chain33-cli
chmod 0777 /usr/local/bin/chain33-cli

# install bityuan node && run 
curl -fsSL https://raw.githubusercontent.com/bityuan/install-script/master/docker/install-docker.sh | sh
