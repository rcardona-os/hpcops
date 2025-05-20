#!/bin/sh
set -e

echo ">> Unit Test 1 - Generating Key..."
echo ">> Generating MUNGE key..."
/usr/local/bin/create-munge-key -f -r

echo ">> Unit Test 2 - Creating Kubernetes Secret"
echo ">> Creating Kubernetes Secret '$SECRET_NAME' in namespace '$SECRET_NAMESPACE'..."
oc create secret generic "$SECRET_NAME" \
  --from-file=munge.key=/mnt/munge/munge.key \
  -n "$SECRET_NAMESPACE" --dry-run=client -o yaml | oc apply -f -

echo ">> Secret created success."