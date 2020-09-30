#!/bin/bash

NAME=${1:-"example"}
NUM=${2:-"0"}

sed -i "s/example/${NAME}/g" `grep example -rl . \
    --exclude-dir="bin" --exclude-dir=".git"`


if [ -z "`grep "${NAME}" /etc/hosts`" ]; then
sudo cat >> /etc/hosts <<EOF

127.0.0.1 peer0.org1.${NAME}.com
127.0.0.1 peer1.org1.${NAME}.com
127.0.0.1 peer2.org1.${NAME}.com
127.0.0.1 orderer.${NAME}.com
127.0.0.1 ca.org1.${NAME}.com
127.0.0.1 ca.${NAME}.com

EOF
fi

sed -i "s/\${ORDERPORT}/7${NUM}50/g" ./network/configtx/configtx.yaml
sed -i "s/\${ORDERPORT}/7${NUM}50/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${PEER0PORT}/7${NUM}51/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${PEER1PORT}/9${NUM}51/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${PEER2PORT}/8${NUM}51/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${PEER0CODEPORT}/7${NUM}52/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${PEER1CODEPORT}/9${NUM}52/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${PEER2CODEPORT}/8${NUM}52/g" ./network/docker/docker-compose-all.yaml
sed -i "s/\${ORGCAPORT}/7${NUM}54/g" ./network/docker/docker-compose-ca.yaml
sed -i "s/\${CAPORT}/9${NUM}54/g" ./network/docker/docker-compose-ca.yaml
sed -i "s/\${PEER0PORT}/7${NUM}51/g" ./network/network.sh
sed -i "s/\${PEER1PORT}/9${NUM}51/g" ./network/network.sh
sed -i "s/\${PEER2PORT}/8${NUM}51/g" ./network/network.sh
sed -i "s/\${CAPORT}/9${NUM}54/g" ./network/network.sh
sed -i "s/\${ORGCAPORT}/7${NUM}54/g" ./network/network.sh
sed -i "s/\${ORDERPORT}/7${NUM}50/g" ./network/network.sh
sed -i "s/\${ORGCAPORT}/7${NUM}54/g" ./network/organizations/ccp-generate.sh
sed -i "s/\${ORDERPORT}/7${NUM}50/g" ./network/scripts/deployCC.sh
sed -i "s/\${PEER0PORT}/7${NUM}51/g" ./network/scripts/envVar.sh
sed -i "s/\${PEER1PORT}/9${NUM}51/g" ./network/scripts/envVar.sh
sed -i "s/\${PEER2PORT}/8${NUM}51/g" ./network/scripts/envVar.sh
