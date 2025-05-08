# High Performance Computing Tolopogies

### Distributed Computing
This architecture involves a network of loosely coupled computers working together to perform very large tasks.
Common Use: Suitable for tasks that can be easily parallelized and distributed, such as grid computing projects and large-scale data processing.
Example Systems: Grid computing projects like SETI@home or distributed computing platforms like Apache Hadoop and Apache Spark.

### Cloud based HPC
Leveraging cloud computing resources to perform HPC tasks. This can be in public, private, or hybrid cloud setups.
Common Use: Offers scalability and flexibility; ideal for organizations requiring HPC resources without the overhead of maintaining physical infrastructure.
Example Systems: Amazon Web Services (AWS) HPC, Microsoft Azure HPC, Google Cloud HPC solutions.

### Shared Memory
Systems where multiple processors share a common address space. This includes Symmetric Multiprocessing (SMP) systems.
Common Use: Ideal for applications that benefit from shared memory for fast data access, but typically limited by the scalability of shared memory systems.
Example Systems: High-end workstations, small to medium-size multiprocessor servers.

### Massively Parallel Processing (MPP)
Consists of many independent processors with their own operating system and memory, working on different parts of a program.
Common Use: Suitable for extremely large computational problems that can be divided into smaller parts.
Example Systems: IBM's Blue Gene series, Cray supercomputers.

### Hybrid Architecture
Combines elements from different architectures, such as mixing distributed and shared memory architectures or integrating cloud components with traditional HPC.
Common Use: Provides flexibility and optimization by leveraging the strengths of different architectures.
Example Systems: Many modern supercomputers employ a hybrid architecture, combining CPUs, GPUs, and sometimes other accelerators.