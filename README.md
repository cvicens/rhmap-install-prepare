
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

# Watch out for duplicated repos...
Repository rhel-7-server-extras-rpms is listed more than once in the configuration
Repository rhel-7-server-rh-common-rpms is listed more than once in the configuration
Repository rhel-7-server-rpms is listed more than once in the configuration
Repository rhel-7-server-optional-rpms is listed more than once in the configuration
Repository rhel-7-fast-datapath-rpms is listed more than once in the configuration
Repository rhel-7-server-ose-3.7-rpms is listed more than once in the configuration

## Commands
mv /etc/yum.repos.d/open_ocp-workshop.repo /etc/yum.repos.d/open_ocp-workshop.repo.old

yum-config-manager --disable rhel-7-server-htb-rpms
yum-config-manager --enable rhel-7-server-extras-rpms rhel-7-server-rh-common-rpms rhel-7-server-rpms rhel-7-server-optional-rpms rhel-7-fast-datapath-rpms rhel-7-server-ose-3.7-rpms


/opt/rhmap/4.6/rhmap-installer/roles/deploy-mbaas/defaults/main.yml ==> look for schedule

===> -e "strict_mode=false" --skip-tags "label"

