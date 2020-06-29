

create_ca () {
  if [ ! -d "work/ca" ]
  then
    echo "Creating CA"
    mkdir -p work/ca
    cfssl genkey -initca config/ca.json | (cd work/ca ; cfssljson -bare ca )
  fi
}

create_i_ca () {
  if [ ! -d "work/i-ca" ]
  then
    echo "Creating Intermediate CA"
    mkdir -p work/i-ca
    cfssl genkey -initca config/i-ca.json | (cd work/i-ca ; cfssljson -bare i-ca )
    cfssl sign -ca work/ca/ca.pem -ca-key work/ca/ca-key.pem -config config/cfssl.json -profile intermediate_ca work/i-ca/i-ca.csr  | (cd work/i-ca ; cfssljson -bare i-ca )

  fi
}

create_host () {
  THISHOST=$1
  if [ ! -d "work/THISHOST" ]
  then
    echo "Creating Certification for $THISHOST"
    mkdir work/$THISHOST
    cat work/i-ca/i-ca.pem work/ca/ca.pem > work/$THISHOST/$THISHOST-bundle.crt
#    cfssl genkey config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST )
#    cfssl gencert -remote work/$THISHOST/$THISHOST.pem -ca-key work/i-ca/i-ca-key.pem -config config/cfssl.json -profile=peer config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-peer )
    cfssl gencert -ca work/i-ca/i-ca.pem -ca-key work/i-ca/i-ca-key.pem -config config/cfssl.json -profile=peer config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-peer )
#    cfssl bundle -ca-bundle work/ca/ca.pem -int-bundle work/i-ca/i-ca.pem -cert work/$THISHOST/$THISHOST-peer.pem -flavor force | jq -r '.bundle' > work/$THISHOST/$THISHOST-peer-bundle.pem
    cfssl gencert -ca work/i-ca/i-ca.pem -ca-key work/i-ca/i-ca-key.pem -config config/cfssl.json -profile=server config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-server )
#    cfssl bundle -ca-bundle work/ca/ca.pem -int-bundle work/i-ca/i-ca.pem -cert work/$THISHOST/$THISHOST-server.pem -flavor force | jq -r '.bundle' > work/$THISHOST/$THISHOST-server-bundle.pem
    cfssl gencert -ca work/i-ca/i-ca.pem -ca-key work/i-ca/i-ca-key.pem -config config/cfssl.json -profile=client config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-client )
#    cfssl bundle -ca-bundle work/ca/ca.pem -int-bundle work/i-ca/i-ca.pem -cert work/$THISHOST/$THISHOST-client.pem -flavor force | jq -r '.bundle' > work/$THISHOST/$THISHOST-client-bundle.pem
  fi
}


create_ca
create_i_ca
create_host "host1"







