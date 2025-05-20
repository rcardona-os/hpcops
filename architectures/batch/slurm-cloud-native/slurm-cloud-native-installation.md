
- enable security context constrains
```bash
oc adm policy add-scc-to-user munge-secret-scc -z munge-secret-sa
```
```bash
oc adm policy add-scc-to-user slurm-scc -z slurm-sa
```

- deploy control
```bash
$ oc apply -f manifests/
```