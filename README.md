# assignment-gdnotes

Total Time taken : 6 hours

#Install Kind

Install KinD from the Step : s://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64

# Create the Multinode KinD cluster

In this step we create the KinD cluster using kind-config.yml

And Verify the that pods spin up is complete 

Command : kubectl get pods

# Setup Ingress route

In this setup we setup the ingress controller in the ingress-nginx namespace.

And verify the running pods in ingress-nginx namespace

# Deploy Echo Apps

This composite action deploys two lightweight HTTP echo server applications (foo and bar) to a Kubernetes cluster in the echo namespace, configures an NGINX Ingress for host-based routing, and validates that the applications are reachable via their defined Ingress hosts.

Two services are deployed for Performance Testing foo.local and bar.local.

Validations has been done to check if both the services are running using port forwarding to localhost:8080

# Run Jmeter Test

Installation of Jmeter 5.6.3 version 

Creating the script to run the load test on two services running foo.local and bar.local

load-test.jmx file is generated using the Jmeter to load test foo.local and bar.local and jtl file is generated.

#Post JMeter Results to PR

The results of the Jmeter test are shared on the PR comments.

# Deploy Prometheus

Prometheus installation is done in the default monitoring namespace.

# Collect Prometheus Metrics

Collect the prometheus metrics from all the namespaces


