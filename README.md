
# Prepare NFS

As root or using sudo

mkdir /srv/nfs/rhm
chown -R nfsnobody:nfsnobody /srv/nfs/rhm
chmod -R uga+rwx /srv/nfs/rhm


# Define NFS export
vi /etc/exports.d/ocp-workshop-oslo2.exports

Add:

```
/srv/nfs/rhm *(rw,root_squash,no_wdelay,sync)
```

# Restart NFS

systemctl restart nfs-server

```
# exportfs 
/srv/nfs/user-vols      <world>
/srv/nfs/rhm  	        <world>
```