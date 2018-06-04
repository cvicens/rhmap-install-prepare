#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "$0 <NFS_SERVER> <NFS_DIR> <PV_SIZE> <PV_QUANTITY>"
    exit 0
fi

NFS_SERVER=$1
NFS_DIR=$2
PV_SIZE=$3
PV_QUANTITY=$4

echo "${NFS_SERVER} ${PV_SIZE} ${PV_QUANTITY}"

for (( i=1; i<=${PV_QUANTITY}; i++ ))
do
PV_NAME="rhm-pv-${PV_SIZE}-$i"
ansible -i hosts ${NFS_SERVER} nfs -m shell -a"mkdir -p ${NFS_DIR}/${PV_NAME}"
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