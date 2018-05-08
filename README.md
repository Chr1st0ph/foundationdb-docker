### FoundationDB

Docker image for running [https://www.foundationdb.org](https://www.foundationdb.org)

##### Run:

* docker run -it chr1st0ph/foundationdb

##### How to connect using fdbcli:

* docker ps -a ( for getting CONTAINER_ID )
* docker exec -it CONTAINER_ID fdbcli
