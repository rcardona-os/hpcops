# HPC System Architectures In The Industry

In the realm of High-Performance Computing (HPC), various architectural models are employed to address different computational needs and scenarios. These architectures are designed to maximize performance, efficiency, and scalability for handling intensive computational tasks. Let's look at some of the key types of architectures you might encounter in HPC:

### [Batch Processing Architecture](architectures/batch/README.md)
This is a traditional HPC architecture where jobs are submitted to a queue and processed in batches. The system schedules and runs these jobs without real-time interaction with the user.
Common Use: Widely used in scenarios where tasks don't require immediate results, like large simulations, scientific computations, and data analysis.
Example Systems: Systems using job schedulers like Slurm, Torque, or PBS Professional.

### [Service-Oriented Architecture (SOA)](architectures/soa/README.md)
In an SOA, HPC services are made available as network-accessible endpoints. This architecture supports more interactive or on-demand computing.
Common Use: Useful for applications requiring real-time or near-real-time data processing, integration with other services (like web services), and in enterprise environments.
Example Systems: IBM Platform Symphony is an example of an HPC system employing SOA.


---

### Conclusion

The choice of architecture in an HPC environment depends on various factors, including the nature of the computational tasks, performance requirements, scalability needs, and available resources. The evolution of HPC has led to a diverse range of architectural models, each with its strengths and specific use cases.