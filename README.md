# ATC_ASSESSMENT

# 1. Provisioning Cloud Infrastructure

## a. Using Terraform to provision the cloud infrastructure on AWS

- VPC and subnet where the cluster is created
- EKS cluster created 

## b. Deploy the terraform files
- The file `main.tf` in the repository has the teraform code to be deployed 
- Replace the **project-name**, **bucket-name** and **credentials** in the file
- Run the following commands
```bash
terraform init
terraform plan
terraform apply
```
# 2. Create and deploy the web application
- Create the web application using the files `Dockerfile` and `index.html` in the repository..
- Dockerise the application using the `Dockerfile`. To create and push the image in Docker Hub registry
```
docker build -t my-web-app:latest
docker tag my-web-app <repository>/my-web-app:latest
docker push my-web-app/my-web-app:latest
```
- Create the kubernetes manifest files from `deployment.yaml` and `service.yaml`  
- In deployment.yaml file replace the image name with your image name.
- Deploy the application by running the following commands
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
- The application would be up and running.

# 3. Configuring Prometheus for Monitoring
- Install prometheus, grafana using Helm in the kubernetes cluster
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 

helm repo update 

helm install [RELEASE_NAME] prometheus-community/prometheus -f prometheus.yaml 
```
- the `prometheus.yaml` file is loated in the repository
- This command would install Prometheus-server, Alert Manager, Kube-State-Metrics, Node-Exporter and PushGateway. 
- We can add configurations to the prometheus-server. Make changes in prometheus.yaml file and apply the alerting rules 
### To access the prometheus server 
- Expose the server using kubectl expose command 
```
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-access 
```
- create an ingress for this nodeport service 
### To access the prometheus alert manager server
- Expose the server using kubectl expose command 
```
kubectl expose service prometheus-alertmanager --type=NodePort --target-port=9093 --name=alertmanager-access 
```
- Repeat the same process as we have done to access the prometheus server by creating an ingress for this nodeport service. 
### Configure Alert manger for Email notification
- List the configmaps and you will find the prometheus-alertmanager 
```
kubectl get configmaps 
```
- Edit the alertmanager configmap by giving configurations for email notification using the file `prometheus-alert.yaml`
```
kubectl edit configmap prometheus-alertmanager
```
- Refresh the pod, for doing so delete the pod and it will be recreated automatically. 
```
kubectl delete pod prometheus-alertmanager-0 
```
- Email notification will be received  when an alert is created.  
