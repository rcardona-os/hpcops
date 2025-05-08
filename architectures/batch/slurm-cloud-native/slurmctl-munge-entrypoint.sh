#!/bin/bash

# Copy and set permissions for munge.key
cp /tmp/munge.key /etc/munge/munge.key
chown munge:munge /etc/munge/munge.key
chmod 400 /etc/munge/munge.key

# Ensure necessary directories exist
mkdir -p /var/run/munge
chown munge:munge /var/run/munge

# Start munged as 'munge' user
runuser -u munge -- /usr/sbin/munged --foreground &

# Copy and set permissions for munge.key
cp /tmp/slurmdbd.conf /etc/slurm/slurmdbd.conf
chown slurm /etc/slurm/slurmdbd.conf
chmod 600 /etc/slurm/slurmdbd.conf

# Start slurmdbd as 'root' user
/usr/sbin/slurmdbd -D &

# Start slurmctld as 'root' user
/usr/sbin/slurmctld -D &

# Wait for background processes
wait
