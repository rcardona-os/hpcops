# Deploying Slurm on OpenShift using OpenShift Virtualization

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Architecture Overview](#architecture-overview)
4. [Installation Steps](#installation-steps)
    - [1. Setting up OpenShift Cluster](#1-setting-up-openshift-cluster)
    - [2. Installing OpenShift Virtualization](#2-installing-openshift-virtualization)
    - [3. Preparing Slurm Virtual Machine Images](#3-preparing-slurm-virtual-machine-images)
    - [4. Configuring and Deploying Slurm](#4-configuring-and-deploying-slurm)
5. [Configuration](#configuration)
    - [Slurm Configuration](#slurm-configuration)
    - [Networking Configuration](#networking-configuration)
6. [Monitoring and Management](#monitoring-and-management)
7. [Troubleshooting](#troubleshooting)
8. [References](#references)

## Introduction
This document outlines the steps required to deploy the Slurm workload manager on an OpenShift cluster using OpenShift Virtualization. Slurm is a highly scalable cluster management and job scheduling system for large and small Linux clusters.

## Prerequisites
- **OpenShift Container Platform**: Ensure you have version X.X or higher.
- **OpenShift Virtualization Operator**: This should be installed and running.
- **Cluster Resources**: Make sure your cluster has sufficient compute and storage resources.
- **Administrator Access**: Required for managing the OpenShift cluster.
- **Familiarity with OpenShift and Kubernetes**: Basic understanding of these platforms is assumed.

## Architecture Overview
- **Control Plane**: Includes the Slurm Controller and Database virtual machines responsible for managing job queues and scheduling.
- **Compute Nodes**: Virtual machines where Slurm runs the computational jobs.
- **Networking**: Proper networking setup to ensure seamless communication between VMs and OpenShift services.

## Installation Steps

### 1. Setting up OpenShift Cluster
- **Provisioning**: Set up an OpenShift cluster with necessary compute and storage resources.
- **OpenShift CLI**: Install and configure the `oc` CLI tool for managing the cluster.

### 2. Installing OpenShift Virtualization
- **Operator Installation**: Navigate to the OpenShift web console and install the OpenShift Virtualization Operator from the OperatorHub.
- **Verification**: Check the status of the KubeVirt components to ensure they are running correctly.

### 3. Preparing Slurm Virtual Machine Images
- **Base VM Image**: Create a base virtual machine image (e.g., using RHEL or Fedora).
- **Dependencies**: Install necessary dependencies such as Slurm, munge, and any other required packages.
- **Customization**: Customize the VM images with Slurm configurations and scripts.
- **Upload**: Upload the prepared VM images to OpenShift Virtualization for use.

### 4. Configuring and Deploying Slurm
- **VirtualMachine Resources**: Create a Kubernetes `VirtualMachine` resource for the Slurm Controller.
- **VirtualMachineInstance Resources**: Create `VirtualMachineInstance` resources for the compute nodes.
- **Configuration**: Apply configurations such as shared storage and network policies to ensure proper functionality.

## Configuration

### Slurm Configuration
- **slurm.conf**: Define the main configuration file for Slurm with settings specific to your cluster.
- **munge Authentication**: Set up `munge` for secure authentication across the cluster and distribute keys to all nodes.
- **Daemon Setup**: Start the Slurm daemons on the Controller and Compute Nodes.

### Networking Configuration
- **VM Network**: Ensure all VMs are connected to the same network to allow for seamless communication.
- **Network Policies**: Configure network policies or firewall rules as needed to secure communication.

## Monitoring and Management
- **OpenShift Monitoring Tools**: Utilize OpenShift monitoring tools like Prometheus and Grafana to monitor the health and performance of the VMs and Slurm daemons.
- **Health Checks**: Regularly check the health of the Slurm Controller and Compute Nodes to ensure they are functioning correctly.
- **Scaling**: Scale the number of compute nodes based on workload requirements.

## Troubleshooting
- **Logs**: Check VM and Pod logs for any errors or issues (`oc logs <vm-name>`).
- **Network Connectivity**: Verify that network connectivity between Slurm components is working correctly.
- **Service Status**: Ensure all Slurm services are running as expected.
- **Documentation**: Refer to Slurm and OpenShift documentation for common issues and solutions.

## References
- [OpenShift Documentation](https://docs.openshift.com/)
- [OpenShift Virtualization Documentation](https://docs.openshift.com/container-platform/latest/virt/virt-overview.html)
- [Slurm Documentation](https://slurm.schedmd.com/documentation.html)
