## 搭建单组织三节点的分布式Fabric网络
1、git clone 本项目

2、进入Newland/network，执行./network up -ca 启动机器A

3、拷贝network目录到机器B，进入机器B的network目录，执行 docker-compose -f docker/docker-compose-peer.yaml up -d

4、机器A执行 ./network createChannel 创建通道

5、机器A执行./network.sh deployCC -ccn newland -ccv 1 -cci Init -ccl go -ccp ../chaincode/newland  安装智能合约

6、进入NewLand/scripts目录，分别执行
    node enrollAdmin
    node registerUser
    node invoke
    node query
    测试智能合约

注：需要配置/etc/hosts，指定AB两台机器的IP和自定义域名，参考如下:

    192.168.204.15 peer0.org1.example.com
    192.168.204.14 peer1.org1.example.com
    192.168.204.15 peer2.org1.example.com
    192.168.204.15 orderer.example.com
    192.168.204.15 ca.example.com
    192.168.204.15 ca.org1.example.com
~                                       
