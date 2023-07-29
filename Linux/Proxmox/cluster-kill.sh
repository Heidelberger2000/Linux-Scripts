#First, stop the corosync and pve-cluster services on the node:

systemctl stop pve-cluster
systemctl stop corosync

#Start the cluster file system again in local mode:

pmxcfs -l

#Delete the corosync configuration files:

rm /etc/pve/corosync.conf
rm -r /etc/corosync/*

#You can now start the file system again as a normal service:

killall pmxcfs
systemctl start pve-cluster

#The node is now separated from the cluster. You can deleted it from any remaining node of the cluster with:

pvecm delnode oldnode

#If the command fails due to a loss of quorum in the remaining node, you can set the expected votes to 1 as a workaround:

pvecm expected 1

#And then repeat the pvecm delnode command.

#Now switch back to the separated node and delete all the remaining cluster files on it. This ensures that the node can be added to another cluster again without problems.

rm /var/lib/corosync/*

#As the configuration files from the other nodes are still in the cluster file system, you may want to clean those up too. After making absolutely sure that you have the correct node name, you can simply remove the entire directory recursively from /etc/pve/nodes/NODENAME.
