NET_NAME=default

virsh net-destroy $NET_NAME
virsh net-start $NET_NAME