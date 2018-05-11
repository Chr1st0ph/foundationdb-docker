## FoundationDB

Docker image for running [https://www.foundationdb.org](https://www.foundationdb.org)

### Run:

* docker run -it chr1st0ph/foundationdb

### How to connect using fdbcli:

* docker ps -a ( for getting CONTAINER_ID )
* docker exec -it CONTAINER_ID fdbcli

### Environment variables 

FDB\_DATACENTER\_ID : set "datacenter_id" in /etc/foundationdb/foundationdb.conf

"FDB\_MACHINE\_ID" : set "machine_id" in /etc/foundationdb/foundationdb.conf

e.g docker run -it -e FDB_DATACENTER_ID=DC1 -e FDB_MACHINE_ID=minikube chr1st0ph/foundationdb
