#!/bin/bash

if [ $FDB_COORDINATORS_FQDN ] && [ ! -f /etc/foundationdb/configured ]; then
	IFS=', ' read -r -a fqdn_array <<< $FDB_COORDINATORS_FQDN

	rm -r /var/lib/foundationdb/data/4500
	rm -r /var/log/foundationdb/trace*

	ips_str=""
	for fqdn in "${fqdn_array[@]}"
	do
		ip_for_fqdn=`getent hosts $fqdn | awk '{ print $1}'`
		if [ ! $ip_for_fqdn ]; then
			echo unable to determine ip for '$fqdn'
			exit 1
		fi
		
		ips_str+=",$ip_for_fqdn:4500"
	done

	rm /etc/foundationdb/fdb.cluster
	echo $FDB_CLUSTER_CONTENT >> /etc/foundationdb/fdb.cluster
	echo $(cat /etc/foundationdb/fdb.cluster)$ips_str > /etc/foundationdb/fdb.cluster
  	
  	sed -i -e 's/127.0.0.1:4500,//g' /etc/foundationdb/fdb.cluster

	echo updated /etc/foundationdb/fdb.cluster to `cat /etc/foundationdb/fdb.cluster`

	touch /etc/foundationdb/configured
fi

if [ $FDB_DATACENTER_ID ]; then
	sed -i "s/# datacenter_id =.*/datacenter_id = $FDB_DATACENTER_ID/" /etc/foundationdb/foundationdb.conf
fi
if [ $FDB_MACHINE_ID ]; then
	sed -i "s/# machine_id =.*/machine_id = $FDB_MACHINE_ID/" /etc/foundationdb/foundationdb.conf
fi

/usr/lib/foundationdb/fdbmonitor
