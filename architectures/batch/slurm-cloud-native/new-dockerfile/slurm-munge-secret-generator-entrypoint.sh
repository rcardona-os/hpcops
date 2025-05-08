set -e

# Run initial setup as root
if [ "$(id -u)" = "0" ]; then
    # Set default MUNGEUSER if not set
    MUNGEUSER=${MUNGEUSER:-1001}

    # Check if the group exists before adding
    if ! getent group munge > /dev/null; then
        groupadd -g $MUNGEUSER munge
    fi

    # Check if the user exists before adding
    if ! getent passwd munge > /dev/null; then
        useradd -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge -s /sbin/nologin munge
    fi

    # Create munge key if it doesn't exist
    if [ ! -f /etc/munge/munge.key ]; then
        /usr/sbin/create-munge-key -r
    fi

    # Adjust ownership and permissions
    chown $MUNGEUSER:$MUNGEUSER /etc/munge/munge.key
    chmod 0644 /etc/munge/munge.key
    chown $MUNGEUSER:$MUNGEUSER /etc/munge
    chmod 0755 /etc/munge

    # Switch to non-root user
    exec su munge -s /bin/bash "$0" -- "$@"
fi

# Run as non-root user from here on

# Create the Kubernetes secret
oc create secret generic munge-key-secret --from-file=/etc/munge/munge.key || echo 'Failed to create secret'

