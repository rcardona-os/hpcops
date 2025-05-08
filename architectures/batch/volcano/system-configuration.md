
In Red Hat OpenShift, you have the option to deploy a bespoke secondary scheduler alongside the platform's default scheduler, which is made possible by the Secondary Scheduler Operator. This auxiliary scheduler operates in tandem with the existing one, providing enhanced flexibility in pod scheduling. When configuring pod setups, you can specify the preferred scheduler. It's crucial for the custom scheduler to include the /bin/kube-scheduler binary and be constructed based on the Kubernetes scheduling framework. This setup offers a tailored approach to managing pod deployment within OpenShift Container Platform. For more detailed guidance, you might want to refer directly to the OpenShift [documentation](https://docs.openshift.com/container-platform/4.15/nodes/scheduling/secondary_scheduler/index.html).

The Secondary Scheduler Operator is responsible for establishing the required roles and role bindings for the secondary scheduler. It offers the capability to tailor the KubeSchedulerConfiguration resource for the secondary scheduler. This enables precise control over which scheduling plugins are enabled or disabled, ensuring a tailored and efficient scheduling process. For detailed information and guidance, it's recommended to refer to the OpenShift documentation.

__Step 1__: Install the Secondary Scheduler Operator

- Create a namespace  openshift-secondary-scheduler-operator to install the Secondary Scheduler Operator first.
  ```bash
  oc create ns openshift-secondary-scheduler-operator
  ```

- Open the OperatorHub console to search for the Secondary Scheduler Operator.


Click on Install to install the Secondary Scheduler Operator.
Choose the project namespace as openshift-secondary-scheduler-operator.
Now the operator is ready to use.

__Step 2__: Configure the Secondary Scheduler Operator to install Trimaran scheduler as a secondary scheduler

  - 2.0 - Define KubeSchedulerConfiguration for the [Trimaran scheduler](https://github.com/kubernetes-sigs/scheduler-plugins/blob/master/pkg/trimaran/README.md) that runs TargetLoadPacking plugin. __The schedulerName should be set as secondary-scheduler__.

    ```yaml
    echo -e 'apiVersion: v1
    kind: ConfigMap
    metadata:
      name: "secondary-scheduler-config"                  
      namespace: "openshift-secondary-scheduler-operator" 
    data:
      "config.yaml": |
        apiVersion: kubescheduler.config.k8s.io/v1beta3
        kind: KubeSchedulerConfiguration                  
        leaderElection:
          leaderElect: false
        profiles:
          - schedulerName: secondary-scheduler            
            plugins:                                      
              score:
                disabled:
                  - name: NodeResourcesBalancedAllocation
                  - name: NodeResourcesLeastAllocated' | tee KubeSchedulerConfiguration-cm.yaml
  ```
