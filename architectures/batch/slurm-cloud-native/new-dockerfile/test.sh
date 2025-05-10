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

# Create the munge key if it doesn't exist
echo "4- Create the munge key if it doesn't exist"
#if [ ! -f /etc/munge/munge.key ]; then
#    /usr/sbin/create-munge-key -r
#fi
echo "END 4-"

# Adjust ownership and permissions
#chown $MUNGEUSER:$MUNGEUSER /etc/munge/munge.key
#chmod 0644 /etc/munge/munge.key
#chown $MUNGEUSER:$MUNGEUSER /etc/munge
#chmod 0755 /etc/munge

# Optionally, log completion
#echo "Munge key setup completed as root."
echo "Script completed. Sleeping to keep container alive..."
sleep infinity