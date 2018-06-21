#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "$0 <SSH_USER> <NFS_SERVER> <NFS_DIR> <PV_SIZE> <PV_QUANTITY>"
    exit 0
fi

SSH_USER=$1
NFS_SERVER=$2
NFS_DIR=$3
PV_SIZE=$4
PV_QUANTITY=$5

echo "${NFS_SERVER} ${PV_SIZE} ${PV_QUANTITY}"

for (( i=1; i<=${PV_QUANTITY}; i++ ))
do
PV_NAME="rhm-pv-${PV_SIZE}-$i"
ansible -i hosts nfs -u ec2-user --become -m file -a "dest=${NFS_DIR}/${PV_NAME} mode=777 owner=nfsnobody group=nfsnobody state=directory"
cat << EOF > ./dyn1-pv-create.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
 name: ${PV_NAME}
spec:
 capacity:
   storage: ${PV_SIZE}Gi
 accessModes:
   - ReadWriteOnce
 persistentVolumeReclaimPolicy: Recycle
 nfs:
   path: ${NFS_DIR}/${PV_NAME}
   server: $NFS_SERVER
   readOnly: false
EOF
oc create -f ./dyn1-pv-create.yaml



done