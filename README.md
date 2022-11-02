# ovpn-docker
Initialize an ovpn-server container quickly
```
# docker 安装 国际流量
# install docker 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt-get upgrade
```
> reference: "https://docs.docker.com/engine/install/ubuntu/"

```
# 变量设置
# set var
OVPN_DATA="ovpn-data"
HOST_NAME="ovpn.example.com"
HOST_PORT="1194"
CLIENT_NAME="<YourClientName>"

# 生成存储容器
# generate a storage container
sudo docker run --name $OVPN_DATA -v /etc/openvpn busybox

# 配置文件/密钥对生成
# generate an ovpn-server config file and pki
sudo docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://$HOST_NAME:$HOST_PORT
sudo docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki

# 服务启动
# run the server
sudo docker run --volumes-from $OVPN_DATA --restart=always --name ovpn-runtime -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

# 客户端密钥对/配置文件生成
# generate a cient key and a client config file
sudo docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENT_NAME nopass
sudo docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient $CLIENT_NAME > $CLIENT_NAME@$HOST_NAME.ovpn
```
> reference: "https://www.digitalocean.com/community/tutorials/how-to-run-openvpn-in-a-docker-container-on-ubuntu-14-04?utm_source=githubreadme"
