#! /usr/bin/expect

set timeout -1
set CA_NAME $env(CA_NAME)
set CA_PASSPHRASE $env(CA_PASSPHRASE)


spawn   ./tar.sh
expect  "*Passphrase: "
send    "$CA_PASSPHRASE\n"
expect  "*Passphrase: "
send    "$CA_PASSPHRASE\n"
expect  "*\[Easy-RSA CA\]:"
send    "$CA_NAME\n"
expect  "*ca.key:"
send    "$CA_PASSPHRASE\n"
expect  "*ca.key:"
send    "$CA_PASSPHRASE\n"
expect  "*ca.key:"
send    "$CA_PASSPHRASE\n"
expect  eof