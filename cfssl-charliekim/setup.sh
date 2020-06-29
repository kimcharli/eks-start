

create_ca () {
  if [ ! -d "work/ca" ]
  then
    echo "Creating CA"
    mkdir -p work/ca
    cfssl genkey -initca config/ca.json | (cd work/ca ; cfssljson -bare ca )
  fi
}


create_host () {
  THISHOST=host-$1
  if [ ! -d "work/THISHOST" ]
  then
    echo "Creating Certification for $THISHOST"
    mkdir work/$THISHOST
    cat work/ca/ca.pem work/ca/ca.pem > work/$THISHOST/$THISHOST-bundle.crt
    cfssl gencert -ca work/ca/ca.pem -ca-key work/ca/ca-key.pem -config config/cfssl.json -profile=peer config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-peer )
    cfssl gencert -ca work/ca/ca.pem -ca-key work/ca/ca-key.pem -config config/cfssl.json -profile=client config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-client )
    cfssl gencert -ca work/ca/ca.pem -ca-key work/ca/ca-key.pem -config config/cfssl.json -profile=server config/$THISHOST.json | ( cd work/$THISHOST ; cfssljson -bare $THISHOST-server )
  fi
}


create_ca
#create_i_ca
create_host "www"







