#! /bin/sh

# Make sure expect is installed.
# Before excuting, make sure your docker is installed.
# Make sure the container's name is unique

# set variables here
OVPN_DATA="ovpn-data"
OVPN_CONTAINER_NAME="ovpn-runtime"
HOST_NAME="<ovpn.example.com>"
HOST_PORT="1194"
CLIENT_NAME="<YourClientName>"
TRANSPORT_PROTOCOL="udp"

CA_PASSPHRASE="<YourCaPhrase>"
CA_NAME="<YourCaName>"

export OVPN_DATA
export OVPN_CONTAINER_NAME
export HOST_NAME
export HOST_PORT
export CLIENT_NAME
export TRANSPORT_PROTOCOL
export CA_PASSPHRASE
export CA_NAME

./exauto.sh
