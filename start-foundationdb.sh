#!/bin/bash

if [ $FDB_COORDINATORS_FQDN ]; then
	IFS=', ' read -r -a fqdn_array <<< $FDB_COORDINATORS_FQDN
	
	ips_str=""
	for fqdn in "${fqdn_array[@]}"
	do
		ip_for_fqdn=`getent hosts $fqdn | awk '{ print $1}'`
		ips_str+=",$ip_for_fqdn:4500"
	done

	echo $(cat /etc/foundationdb/fdb.cluster)$ips_str > /etc/foundationdb/fdb.cluster
  	
  	sed -i -e 's/127.0.0.1:4500,//g' /etc/foundationdb/fdb.cluster
fi

/usr/lib/foundationdb/fdbmonitor
