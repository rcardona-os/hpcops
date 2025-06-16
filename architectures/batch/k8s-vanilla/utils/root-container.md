
- create root container with deployment (dynamic pod name)
```bash
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ubuntu-root
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ubuntu-root
  template:
    metadata:
      labels:
        app: ubuntu-root
    spec:
      containers:
      - name: ubuntu
        image: ubuntu:24.04
        command: ["/bin/bash", "-c", "--"]
        args: ["while true; do sleep 3600; done;"]
        securityContext:
          runAsUser: 0
          privileged: true
        tty: true
        stdin: true
EOF
```


- create root pod with pod definition
```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-root
spec:
  containers:
  - name: ubuntu
    image: ubuntu:24.04
    command: ["/bin/bash", "-c", "--"]
    args: ["while true; do sleep 3600; done;"]
    securityContext:
      runAsUser: 0
      privileged: true
    tty: true
    stdin: true
EOF
```