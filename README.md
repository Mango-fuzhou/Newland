## 搭建单组织三节点的分布式Fabric网络，支持多人同台机上部署
1、git clone 到本地，支持多人同台机器部署，需要修改目录名称和别人区分,这边我修改成Mango，进入Newland/network目录，执行bootstrap.sh下载docker镜像

2、进入Mango目录，执行一下脚本初始化，参数1为自己的目录名，参数二为自己的端口序号从0开始递增
    
    ./setup.sh Mango 0
    
2、进入Mango/network，执行以下命令启动A机器网络

    ./network up -ca

3、机器A执行以下命令创建通道

    ./network createChannel

4、机器A执行以下命令安装智能合约

    ./network.sh deployCC -ccn newland -ccv 1 -cci Init -ccl go -ccp ../chaincode/newland

5、进入NewLand/scripts目录，分别执行以下命令测试智能合约：

    node enrollAdmin
    
    node registerUser
    
    node invoke
    
    node query
