
#### commands inside munge container
```bash
sudo groupadd -g $MUNGEUSER munge
sudo useradd -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
export SLURMUSER=1002
sudo groupadd -g $SLURMUSER slurm
sudo useradd -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /bin/bash slurm
sudo dnf install munge munge-libs munge-devel -y
```

#### build image
```bash
$ podman build -t munge-key-and-secret-generator .
```

```bash
$ podman build -t munge-process .
```

```bash
$ podman build -t slurmctl-process .
```

```bash
$ podman pod create --name mypod
```

```bash
$ podman run -dt --pod mypod --name mycontainer rhel9-slurm-munge
```

```bash
$ podman run -it munge-key-and-secret-generator
```

#### create a container
```bash
podman run -it munge-process

podman run -dt --pod mypod munge-process
```


install ps command
dnf install -y procps


/usr/sbin/munged --foreground

munge command to test funtionality
munge -n



oc new-app mariadb-ephemeral \
-p MYSQL_ROOT_PASSWORD=password \
-p MYSQL_USER=slurm \
-p MYSQL_PASSWORD=password \
-p MYSQL_DATABASE=test \
-p DATABASE_SERVICE_NAME=testdb


mysql -p -u slurm -h mariadb slurm_acct_db



mysql -p -u slurm -h mariadb slurm_acct_db


oc new-app mariadb-persistent \
-p MYSQL_ROOT_PASSWORD=password \
-p DATABASE_SERVICE_NAME=slurmdb \
-p MYSQL_USER=slurm \
-p MYSQL_PASSWORD=password \
-p MYSQL_DATABASE=slurm_acct_db \
-p VOLUME_CAPACITY=256Mi


mysql -p -u slurm slurm_acct_db

mysql -p -u slurm -h slurmdb slurm_acct_db


oc exec -it slurmctl-6b57cddcc6-gqdhg -c munge-process -- /bin/bash



please modify the current Dockerfile so it can create a simple container image with the most if the funtionality in a so call "entrypoint.sh"






---
new 08-05-2025

#### build image

```bash
$ podman build -f Dockerfile-munge-key-secret-generator \
  -t quay.io/rcardona/munge-key-secret-generator:test .
```