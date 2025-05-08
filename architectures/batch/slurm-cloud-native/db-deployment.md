- create database
```bash
oc new-app mariadb-persistent \
-p MYSQL_ROOT_PASSWORD=password \
-p DATABASE_SERVICE_NAME=slurmdb \
-p MYSQL_USER=slurm \
-p MYSQL_PASSWORD=password \
-p MYSQL_DATABASE=slurm_acct_db \
-p VOLUME_CAPACITY=256Mi
```