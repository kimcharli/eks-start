### build
```bash
ckim-mbp:hello ckim$ export GOPATH=~/go
ckim-mbp:hello ckim$ git clone git@github.com:cloudflare/cfssl.git $GOPATH/src/github.com/cloudflare/cfssl
Cloning into '/Users/ckim/go/src/github.com/cloudflare/cfssl'...
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 11240 (delta 0), reused 1 (delta 0), pack-reused 11235
Receiving objects: 100% (11240/11240), 13.98 MiB | 3.03 MiB/s, done.
Resolving deltas: 100% (5097/5097), done.
ckim-mbp:hello ckim$ cd $GOPATH/src/github.com/cloudflare/cfssl
ckim-mbp:cfssl ckim$ make
go build -o bin/rice ./vendor/github.com/GeertJohan/go.rice/rice
./bin/rice embed-go -i=./cli/serve
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/cfssl ./cmd/cfssl
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/cfssl-bundle ./cmd/cfssl-bundle
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/cfssl-certinfo ./cmd/cfssl-certinfo
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/cfssl-newkey ./cmd/cfssl-newkey
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/cfssl-scan ./cmd/cfssl-scan
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/cfssljson ./cmd/cfssljson
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/mkbundle ./cmd/mkbundle
go build -ldflags "-s -w -X github.com/cloudflare/cfssl/cli/version.version=1.4.1" -o bin/multirootca ./cmd/multirootca
ckim-mbp:cfssl ckim$

```

```bash
ckim-mbp:~ ckim$ go get -u github.com/cloudflare/cfssl/cmd/...
ckim-mbp:~ ckim$ ls /Users/ckim/go/bin/
cfssl		cfssl-bundle	cfssl-certinfo	cfssl-newkey	cfssl-scan	cfssljson	hello		mkbundle	multirootca
ckim-mbp:~ ckim$
```


### with Docker
```bash
ckim-mbp:temp ckim$ docker pull cfssl/cfssl
ckim-mbp:~ ckim$ docker run --rm cfssl/cfssl serve

```


## steps

```
ckim-mbp:cfssl ckim$ rm -rf work/*
ckim-mbp:cfssl ckim$ tree
.
├── README.md
├── config
│   ├── ca.json
│   ├── cfssl.json
│   ├── csr.json
│   ├── host1.json
│   └── i-ca.json
├── setup.sh
└── work

2 directories, 7 files
ckim-mbp:cfssl ckim$ 

```

```
ckim-mbp:cfssl ckim$ ./setup.sh 
Creating CA
2020/06/29 03:13:19 [INFO] generate received request
2020/06/29 03:13:19 [INFO] received CSR
2020/06/29 03:13:19 [INFO] generating key: rsa-2048
2020/06/29 03:13:19 [INFO] encoded CSR
2020/06/29 03:13:19 [INFO] signed certificate with serial number 728786798414952101269214738362320431256791754612
Creating Intermediate CA
2020/06/29 03:13:19 [INFO] generate received request
2020/06/29 03:13:19 [INFO] received CSR
2020/06/29 03:13:19 [INFO] generating key: rsa-2048
2020/06/29 03:13:19 [INFO] encoded CSR
2020/06/29 03:13:19 [INFO] signed certificate with serial number 506688776660001541100898233080084401557531735736
2020/06/29 03:13:19 [INFO] signed certificate with serial number 274479773094415846997213762784526727563182212802
Creating Certification for host1
2020/06/29 03:13:19 [INFO] generate received request
2020/06/29 03:13:19 [INFO] received CSR
2020/06/29 03:13:19 [INFO] generating key: rsa-2048
2020/06/29 03:13:19 [INFO] encoded CSR
2020/06/29 03:13:19 [INFO] signed certificate with serial number 90403413212335545190539102125636132551113532824
2020/06/29 03:13:19 [INFO] generate received request
2020/06/29 03:13:19 [INFO] received CSR
2020/06/29 03:13:19 [INFO] generating key: rsa-2048
2020/06/29 03:13:19 [INFO] encoded CSR
2020/06/29 03:13:19 [INFO] signed certificate with serial number 112603811687361203260207879525038228506147132734
2020/06/29 03:13:19 [INFO] generate received request
2020/06/29 03:13:19 [INFO] received CSR
2020/06/29 03:13:19 [INFO] generating key: rsa-2048
2020/06/29 03:13:20 [INFO] encoded CSR
2020/06/29 03:13:20 [INFO] signed certificate with serial number 319105476274282591301854587943745385035149103433
ckim-mbp:cfssl ckim$ tree
.
├── README.md
├── config
│   ├── ca.json
│   ├── cfssl.json
│   ├── csr.json
│   ├── host1.json
│   └── i-ca.json
├── setup.sh
└── work
    ├── ca
    │   ├── ca-key.pem
    │   ├── ca.csr
    │   └── ca.pem
    ├── host1
    │   ├── host1-bundle.crt
    │   ├── host1-client-key.pem
    │   ├── host1-client.csr
    │   ├── host1-client.pem
    │   ├── host1-peer-key.pem
    │   ├── host1-peer.csr
    │   ├── host1-peer.pem
    │   ├── host1-server-key.pem
    │   ├── host1-server.csr
    │   └── host1-server.pem
    └── i-ca
        ├── i-ca-key.pem
        ├── i-ca.csr
        └── i-ca.pem

5 directories, 23 files
ckim-mbp:cfssl ckim$ 


```


