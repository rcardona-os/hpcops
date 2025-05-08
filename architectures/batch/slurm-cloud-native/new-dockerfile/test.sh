#!/bin/bash
set -e

# Set default MUNGEUSER if not already set
MUNGEUSER=${MUNGEUSER:-1001}

# Check if the group exists before adding
if ! getent group munge > /dev/null; then
    groupadd -g $MUNGEUSER munge
fi

# Check if the user exists before adding
if ! getent passwd munge > /dev/null; then
    useradd -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
fi

echo "Testing USER inside the container"
echo "Running as user ID: $(id -u)"
echo "Running as group ID: $(id -g)"
echo "Finished USER inside the container"

# Create the munge key if it doesn't exist
if [ ! -f /etc/munge/munge.key ]; then
    /usr/sbin/create-munge-key -r
fi

# Adjust ownership and permissions
#chown $MUNGEUSER:$MUNGEUSER /etc/munge/munge.key
#chmod 0644 /etc/munge/munge.key
#chown $MUNGEUSER:$MUNGEUSER /etc/munge
#chmod 0755 /etc/munge

# Optionally, log completion
echo "Munge key setup completed as root."