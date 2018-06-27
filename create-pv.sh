#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "$0 <NFS_SERVER> <PV_NAME> <PV_SIZE>"
    exit 0
fi

NFS_SERVER=$1
PV_NAME=$2
PV_SIZE=$3

cat << EOF > ./pv-create.yaml
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
oc create -f ./pv-create.yaml

done