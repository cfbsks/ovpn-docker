#! /bin/sh

sudo docker run --name $OVPN_DATA -v /etc/openvpn busybox
sudo docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u $TRANSPORT_PROTOCOL://$HOST_NAME:$HOST_PORT
sudo docker run --volumes-from $OVPN_DATA --rm -i kylemanna/openvpn ovpn_initpki
sudo docker run --volumes-from $OVPN_DATA --restart=always --name $OVPN_CONTAINER_NAME -d -p $HOST_PORT:$HOST_PORT/1194 --cap-add=NET_ADMIN kylemanna/openvpn
sudo docker run --volumes-from $OVPN_DATA --rm -i kylemanna/openvpn easyrsa build-client-full $CLIENT_NAME nopass
sudo docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient $CLIENT_NAME > $CLIENT_NAME@$HOST_NAME.ovpn
