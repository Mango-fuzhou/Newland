## 搭建单组织三节点的分布式Fabric网络
1、git clone 本项目，进入Newland/network目录，执行bootstrap.sh下载docker镜像

2、进入Newland/network/docker目录，打开docker-compose.yaml和docker-comose-peer.yaml文件
    
    修改192.168.204.15为A机的外网地址
    
    修改192.168.204.14为B机的外网地址
    
2、进入Newland/network，执行以下命令启动A机器网络

    ./network up -ca

3、拷贝network目录到机器B，进入机器B的network目录执行以下命令，启动B机器网络

    docker-compose -f docker/docker-compose-peer.yaml up -d

4、机器A执行以下命令创建通道

    ./network createChannel

5、机器A执行以下命令安装智能合约

    ./network.sh deployCC -ccn newland -ccv 1 -cci Init -ccl go -ccp ../chaincode/newland

6、进入NewLand/scripts目录，分别执行以下命令测试智能合约：

    node enrollAdmin
    
    node registerUser
    
    node invoke
    
    node query

注：需要配置/etc/hosts，指定AB两台机器的IP和自定义域名，参考如下:

    192.168.204.15 peer0.org1.example.com
    192.168.204.14 peer1.org1.example.com
    192.168.204.15 peer2.org1.example.com
    192.168.204.15 orderer.example.com
    192.168.204.15 ca.example.com
    192.168.204.15 ca.org1.example.com
