#!/bin/sh
set -e

echo ">> Generating MUNGE key..."
/usr/sbin/create-munge-key -f -r

echo ">> Creating Kubernetes Secret '$SECRET_NAME' in namespace '$SECRET_NAMESPACE'..."
oc create secret generic "$SECRET_NAME" \
  --from-file=munge.key=/mnt/munge/munge.key \
  -n "$SECRET_NAMESPACE" --dry-run=client -o yaml | oc apply -f -

echo ">> Secret created successfully."