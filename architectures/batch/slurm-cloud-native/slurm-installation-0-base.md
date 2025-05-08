# Slurm Installation

This installation of slurm comprises 2x (or more) nodes; the control node and compute node(s).

- control: cluster management and login tasks

- compute0: worlkload execution task

#### 0.0 - prerequisites

- ssh passwordless login/access from the control node to the computes

- open ports between nodes:

| Type        | Protocol | Port Range | Source            | Description                           |
|-------------|----------|------------|-------------------|---------------------------------------|
| Custom TCP  | TCP      | 6817       | Control node SG   | Slurmd daemon on compute nodes        |
| Custom TCP  | TCP      | 6818       | Compute nodes SG  | Slurmctld daemon on the control node  |
| Custom TCP  | TCP      | 6819       | Cluster SG        | Slurmdbd daemon for job accounting    |
| Custom TCP  | TCP      | 7321       | Cluster SG        | Munge authentication daemon           |
| Custom TCP  | TCP      | 22         | Your IP / SG      | SSH access                            |
| Custom ICMP | ICMP     | Echo       | Cluster SG        | Ping (for testing connectivity)       |

### NOTE: the following commands have to be executed on all cluster nodes

#### 0.1 - enable rhel repositories
```bash
$ sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
```
```bash
$ sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
```

#### 0.2 - creating cluster users
```bash
$ export MUNGEUSER=1001
```
```bash
$ sudo groupadd -g $MUNGEUSER munge
```
```bash
$ sudo useradd -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
```
```bash
$ export SLURMUSER=1002
```
```bash
$ sudo groupadd -g $SLURMUSER slurm
```
```bash
$ sudo useradd -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm -s /bin/bash slurm
```

#### 0.3 - installing munge
```bash
$ sudo dnf install munge munge-libs munge-devel -y
```
