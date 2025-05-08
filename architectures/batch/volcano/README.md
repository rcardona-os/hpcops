# HPC Batch Based Systems On Red Hat Openshift

Batch processing systems are a predominant architectural choice in high performance computing (HPC), prevalent across both industrial and academic spheres. These systems are characterized by a high degree of sophistication and extensive customization, presenting significant challenges when integrating them into a Kubernetes ecosystem. Achieving this integration requires specific strategies, and in this context, the focus is on configuring an alternative scheduler within Openshift, specifically the [Volcano Scheduler](https://volcano.sh/en/).

The Volcano Scheduler is a specialized system designed to facilitate the execution of high performance workloads on Kubernetes. It extends the capabilities of Kubernetes by incorporating batch scheduling features that are essential for handling complex machine learning and big data tasks. Launched in March 2019, Volcano has gained recognition for its robust performance and was subsequently inducted as an incubation project by the Cloud Native Computing Foundation (CNCF) in April 2022.

---
### System Architecture


![OCP High Level Design](media/hpc-on-ocp-batch-architecture.png)

---
### Volcano Scheduler Architecture

![Volcano High Level Design](media/hpc-on-ocp-volcano.png)

---

### Key features and enhancements of the Volcano Scheduler include:

- __Advanced Scheduling Algorithms__: Volcano introduces a variety of sophisticated scheduling algorithms beyond what is natively available in Kubernetes. These algorithms are optimized for complex, resource-intensive tasks typical in HPC scenarios.

- __Efficient Job Management and Scheduling__: Volcano improves upon Kubernetes' default job scheduling, offering enhanced management and efficient scheduling for batch jobs. This includes better handling of job priorities, dependencies, and resource allocation, ensuring optimal usage of cluster resources.

- __Integration with Mainstream Computing Frameworks__: A notable strength of Volcano is its non-intrusive compatibility with widely-used computing frameworks in the HPC and data science domains, such as TensorFlow, PyTorch, and Apache Spark. This allows users to deploy these frameworks on Kubernetes without substantial modifications.

- __Multi-Architecture Computing Support__: Volcano extends its support to various computing architectures, accommodating a range of hardware configurations. This flexibility is vital for HPC environments, which often involve diverse computational resources, including GPUs and CPUs with specialized capabilities.

- __Enhanced Resource Sharing and Fairness__: Volcano introduces mechanisms for fair resource sharing among users and jobs, effectively managing the allocation of resources in multi-tenant environments. This ensures that resources are equitably distributed, preventing monopolization by certain jobs or users.

- __Queue Management__: It features advanced queue management capabilities, allowing for the configuration of queues based on various parameters such as priority and resource requirements. This ensures that jobs are processed efficiently and in an orderly manner.

By integrating Volcano into Openshfit, organizations can leverage Openshift' scalability and flexibility while addressing the specific demands of HPC workloads. Volcano's advanced scheduling capabilities, support for various computing frameworks, and resource management features make it a powerful tool for enhancing the performance of HPC applications in Kubernetes environments.

---

### Background Concepts:

- __High Performance Computing (HPC)__: HPC refers to the practice of aggregating computing power in a way that delivers much higher performance than one could get out of a typical desktop computer or workstation. This is essential for solving large-scale computation problems in science, engineering, or business.

- __Batch Processing__: In computing, batch processing refers to running jobs or tasks automatically without manual intervention. Each job is typically independent of the others.


### HPC Batch Based System on Openshift:

- Containerization of HPC Applications:

  - In a HPC system that leverages Kubernetes, applications are containerized, encapsulating them along with their specific dependencies and configurations within container images. This approach standardizes the application environment, ensuring consistency and portability across different computing nodes. OpenShift defaults to using [Podman](https://docs.podman.io/en/latest/) as its container management tool. Podman stands out for several technically nuanced reasons:

    - Daemonless Architecture: Unlike traditional container management tools that rely on a central daemon, Podman operates without one. Each container is run as a child process of the Podman command itself. This model eliminates the single point of failure and potential security vulnerabilities associated with a centralized daemon.
    - Compatibility with Docker: Podman is designed to be a drop-in replacement for Docker, offering compatibility at the command-line interface level. This means most Docker commands can be directly replaced with Podman commands. Additionally, Podman can use Dockerfiles for building images, making it easier to transition from Docker-based environments.
    - OCI Compliance: Podman adheres to the Open Container Initiative (OCI) standards for container image formats and runtime specifications. This compliance ensures interoperability with other OCI-compliant tools and prevents vendor lock-in, providing flexibility in a diverse container ecosystem.
    - Container Image Management: Podman facilitates comprehensive image management capabilities, including building, pulling, pushing, and managing container images across various registries.
    - Resource Isolation: Leveraging Linux namespaces and cgroups, Podman isolates containers at the process and system resource level. This isolation is critical in HPC environments where resource allocation and constraints are meticulously managed to optimize compute performance.
    - Podman's security-centric and decentralized architecture make it particularly suitable for high-security environments required by HPC applications. The lack of a daemon and rootless execution capabilities significantly reduce the attack surface, enhancing overall system security.
    - Additionally, Podman forms part of a suite of tools including Buildah and Skopeo. Buildah specializes in building OCI-compliant container images from Dockerfiles or from scratch, without the need for a full container runtime or daemon. Skopeo is a tool for working with remote container registries, allowing for inspection, copying, and deleting of images across various registries without the need to pull.

  
- Openshift Cluster:

  The OpenShift architecture, particularly when adapted for High Performance Computing contexts, is underpinned by a Kubernetes based foundational framework. This is further augmented by an extensive and sophisticated ecosystem tailored for enterprise-grade deployments. Here's a detailed technical breakdown of how this cluster operates:

  - Kubernetes Cluster as the Foundation:

    - Cluster Concept: In Kubernetes, a cluster is a collection of nodes. Nodes are the workhorses where the containerized applications actually run. These nodes can be either physical servers or virtual machines, depending on the deployment model and scalability requirements.
    - Containerized Applications: Applications in this context are encapsulated within containers. Containers package the application code along with its dependencies (libraries, binaries, configuration files, etc.), ensuring a consistent and isolated runtime environment. This is particularly beneficial in HPC setups where applications often require specific, tightly controlled software environments.

  - Master Node (Control Plane) Responsibilities:

    - Cluster State Management: The master node, often referred to as the control plane, is responsible for maintaining the desired state of the cluster. It ensures that the configurations applied by the administrators or through automated processes are reflected in the cluster.
    - API Server: It hosts the Kubernetes API server (kube-apiserver), which is the central management entity that other components and external users interact with. This server processes REST operations, validates them, and updates the corresponding objects in the etcd datastore.
    - Scheduler: The control plane also includes the kube-scheduler, which assigns workloads (containers/pods) to worker nodes, based on resource availability, constraints, and affinity/anti-affinity policies.
    - Controller Manager: It houses various controllers (kube-controller-manager) that regulate the state of the cluster by managing workload life cycles, node status, and more.
    - etcd Database: The control plane maintains etcd, a highly available key-value store that holds the cluster’s configuration data, state, and metadata.

  - Worker Nodes Responsibilities:

    - Running Applications: Worker nodes are responsible for running the containerized applications. Each worker node includes a container runtime (i.e [CRI-O](https://cri-o.io/)) to run the containers.
    - Node Agent (kubelet): Each worker node runs kubelet, an agent that communicates with the Kubernetes API server to ensure that containers are running as expected in the pods.
    - Networking: Worker nodes handle the networking aspect of containers, ensuring that they can communicate with each other and with the outside world as necessary.
    - Pods Management: Pods, the smallest deployable units in Kubernetes, are hosted on these worker nodes. A pod can contain one or multiple containers that share the same network namespace and storage volumes.

  - Role in HPC Environments:

    - Resource Optimization: In an HPC context, the Kubernetes cluster must efficiently manage and allocate computational resources (CPU, memory, I/O) to handle compute-intensive tasks.
    - Scalability: The ability to add or remove nodes dynamically allows the cluster to adapt to the varying computational demands typical in HPC scenarios.
    - Isolation and Consistency: The use of containers ensures that HPC applications run in a consistent environment, isolated from other applications, which is crucial for performance and accuracy in computational tasks.

- Scheduling HPC Jobs:


  Scheduling HPC (High-Performance Computing) jobs in a Kubernetes environment involves a sophisticated and nuanced process. This process ensures that containerized applications, or jobs, are efficiently and effectively distributed across the cluster's nodes, considering their unique computational demands. Here's a detailed technical explanation:

    - Basic Kubernetes Scheduling:

      - Role of the Scheduler: Kubernetes has a built-in component called the scheduler. Its primary function is to assign newly created pods to nodes. Pods are the smallest deployable units in Kubernetes and can contain one or multiple containers.
      - Scheduling Process: When a new pod is created, the scheduler selects a suitable node for the pod to run on. It makes this decision based on several factors, including resource requirements of the pod, resource availability on nodes, and other constraints or policies defined by the user.
  
    - Understanding HPC Job Requirements:

      - Resource Awareness: For HPC jobs, the scheduler must be aware of the specific computational requirements of each job. This includes not just the quantity of resources like CPU and memory, but also the quality or type of resources. For instance, some jobs might require high CPU frequencies or large memory bandwidth.
      - Networking Needs: HPC jobs often involve significant data transfer or inter-process communication, necessitating advanced network capabilities. The scheduler must consider network topology and bandwidth availability.
    
    - Advanced Scheduling for HPC:

      - Hardware Considerations: Modern HPC workloads frequently require specialized hardware like GPUs (Graphics Processing Units), FPGAs (Field Programmable Gate Arrays), or high-performance interconnects. Kubernetes scheduling must account for the presence and availability of these resources.
      - Node Selection Strategies: Advanced scheduling strategies might include node selection based on hardware characteristics. This can be achieved using Kubernetes features like node labels and pod affinity/anti-affinity rules. For instance, a pod that requires GPU resources can be scheduled on a node labeled with a GPU.
      - Custom Schedulers: Kubernetes allows the deployment of custom schedulers for specific requirements. In HPC contexts, a custom scheduler can be designed to better understand and allocate resources for compute-intensive tasks, going beyond the capabilities of the default Kubernetes scheduler.
    
    - Resource Allocation and Optimization:

      - Bin Packing Strategy: This is a strategy where the scheduler places pods in a way that maximizes resource utilization and minimizes the number of used nodes. This approach is efficient for maximizing computational resources but requires careful handling to avoid resource contention among high-load jobs.
      - Fair Scheduling: In a multi-tenant HPC environment, ensuring fair resource allocation across different users and jobs is crucial. The scheduler may implement policies that prioritize jobs or distribute resources equitably.
    
    - Interoperability with HPC Workloads:

      - Batch Scheduling: Many HPC applications are batch jobs that require execution for a set period. Kubernetes needs to integrate with batch scheduling systems to handle these workloads efficiently.
      - Dynamic Scaling: HPC jobs may have varying computational needs during their lifecycle. Kubernetes should dynamically scale resources, adding or removing nodes as required.

- Job and Pod Management:

  - In Kubernetes, an HPC job is typically represented as a series of pods. A pod is the smallest deployable unit and can contain one or more containers.

  - Jobs can be queued and scheduled according to priority and resource availability.

- Resource Allocation:

  - Kubernetes manages the allocation of resources like CPU and memory to pods.

  - In an HPC context, this needs to be fine-tuned to ensure high performance, as HPC applications can be resource-intensive.

- Parallel Processing:

  - HPC often involves parallel processing. Kubernetes can orchestrate the deployment of multiple pods to handle parallel tasks of a job.

  - Kubernetes also supports distributed computing frameworks that can be used for parallel processing of HPC tasks.

- Data Handling and Storage:

  - Efficient data handling is critical in HPC. Kubernetes supports persistent volumes and storage classes for managing storage resources.

  - Integration with high-performance file systems and data repositories is essential for HPC applications.

- Networking:

  - HPC workloads often require sophisticated networking for high-throughput and low-latency communication between nodes.

  - Kubernetes offers various networking solutions that can be optimized for HPC requirements.

- Monitoring and Logging:

  - Monitoring resource usage and performance, as well as logging, are vital for managing HPC applications. Kubernetes provides tools for monitoring the health and performance of the cluster and applications.

- Scalability and Flexibility:

  - Kubernetes excels in scaling applications up or down based on demand, which is beneficial for HPC workloads that may have variable computing needs.

  - The platform allows for dynamic resource allocation, improving the efficiency of resource utilization.

- Security and Isolation:

  - Kubernetes provides security features to isolate workloads and protect sensitive computations, which is important for HPC environments handling sensitive data.

---

### Conclusion:

Implementing an HPC batch-based system on Kubernetes combines the high-performance computing capabilities with the flexibility, scalability, and robustness of container orchestration. This setup allows for efficient resource utilization, easier management of complex computations, and the ability to handle large-scale computational tasks in a distributed and dynamic environment.