# Wisecow Kubernetes Deployment Guide (TLS Enabled)

This guide explains how to deploy the **Wisecow application on Kubernetes with TLS enabled**.  
All required Kubernetes manifests (**deployment.yaml, service.yaml, ingress.yaml**) are already available in this repository.

The Wisecow application runs on **port 4499** inside the container.

---

# Architecture

```
User
 │
 │ HTTPS
 ▼
Ingress Controller (TLS termination)
 │
 │ HTTP
 ▼
Kubernetes Service
 │
 ▼
Wisecow Pod (Port 4499)
```

---

# Prerequisites

Make sure the following tools are installed:

- Docker
- Kubernetes cluster (Minikube / Kind / Kubeadm / Cloud)
- kubectl
- OpenSSL

Check kubectl access:

```bash
kubectl get nodes
```

---

# Step 1 — Build the Docker Image

Build the Wisecow container image.

```bash
docker build -t <your-dockerhub-username>/wisecow:latest .
```

Push the image to Docker Hub.

```bash
docker push <your-dockerhub-username>/wisecow:latest
```

---

# Step 2 — Deploy the Application

Apply the deployment manifest.

```bash
kubectl apply -f deployment.yaml
```

Verify pods are running.

```bash
kubectl get pods
```

---

# Step 3 — Create Kubernetes Service

Apply the service manifest.

```bash
kubectl apply -f service.yaml
```

Verify the service.

```bash
kubectl get svc
```

The service forwards traffic:

```
Port 80 → Container Port 4499
```

---

# Step 4 — Generate TLS Certificate

Create a self-signed TLS certificate.

```bash
openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout tls.key \
-out tls.crt \
-subj "/CN=wisecow.example.com"
```

---

# Step 5 — Create Kubernetes TLS Secret

Create a TLS secret for Kubernetes.

```bash
kubectl create secret tls wisecow-tls \
--cert=tls.crt \
--key=tls.key
```

Verify the secret.

```bash
kubectl get secrets
```

---

# Step 6 — Deploy Ingress

Apply the ingress configuration.

```bash
kubectl apply -f ingress.yaml
```

Check ingress status.

```bash
kubectl get ingress
```

---

# Step 7 — Install NGINX Ingress Controller

Ingress requires a controller to route traffic.

Install NGINX ingress controller.

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

Verify the controller.

```bash
kubectl get pods -n ingress-nginx
```

Wait until the pods are **Running**.

---

# Step 8 — Configure Local DNS

Get the ingress IP.

```bash
kubectl get ingress
```

Example output:

```
wisecow-ingress   wisecow.example.com   192.168.49.2
```

Edit the hosts file.

```bash
sudo nano /etc/hosts
```

Add the following entry:

```
<INGRESS-IP>   wisecow.example.com
```

Example:

```
192.168.49.2   wisecow.example.com
```

---

# Step 9 — Test the Application

Test HTTPS access.

```bash
curl -k https://wisecow.example.com
```

The `-k` flag skips certificate verification since this is a self-signed certificate.

---

# Useful Verification Commands

Check pods

```bash
kubectl get pods
```

Check services

```bash
kubectl get svc
```

Check ingress

```bash
kubectl get ingress
```

Check secrets

```bash
kubectl get secrets
```

---

# Result

The Wisecow application is successfully:

- Containerized using Docker
- Deployed on Kubernetes
- Exposed using Kubernetes Ingress
- Secured with TLS (HTTPS)

This setup demonstrates a **secure containerized application deployment using Kubernetes**.
