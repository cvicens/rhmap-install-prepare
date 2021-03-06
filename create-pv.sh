#!/bin/bash

if [ "$#" -ne 6 ]; then
    echo "$0 <LOGIN_URL> <OC_TOKEN> <NFS_SERVER> <NFS_DIR> <PV_NAME> <PV_SIZE>"
    exit 0
fi

LOGIN_URL=$1
OC_TOKEN=$2
NFS_SERVER=$3
NFS_DIR=$4
PV_NAME=$5
PV_SIZE=$6

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
oc login ${LOGIN_URL} --token=${OC_TOKEN} --insecure-skip-tls-verify
oc create -f ./pv-create.yaml