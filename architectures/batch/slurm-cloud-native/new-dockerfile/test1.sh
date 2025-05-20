#!/bin/bash
set -e

# Set default MUNGEUSER if not already set
echo "1- Set default MUNGEUSER if not already set"
MUNGEUSER=${MUNGEUSER:-1001}
echo "END 1-"

# Check if the group exists before adding
echo "2- Check if the group exists before adding"
if ! getent group munge > /dev/null; then
    groupadd -g $MUNGEUSER munge
fi
echo "END 2-"

# Check if the user exists before adding
echo "3- Check if the user exists before adding"
if ! getent passwd munge > /dev/null; then
    useradd -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
fi
echo "END 3-"

echo "Testing USER inside the container"
echo "Running as user ID: $(id -u)"
echo "Running as group ID: $(id -g)"
echo "Finished USER inside the container"

# Optionally, log completion
#echo "Munge key setup completed as root."
echo "Script completed. Sleeping to keep container alive..."
echo "Script completed. Sleeping to keep container alive..." >> /tmp/test1.txt
sleep infinity