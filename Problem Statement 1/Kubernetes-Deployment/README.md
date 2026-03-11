# Wisecow Kubernetes Deployment with TLS

## Project Overview

This project demonstrates the **containerization and deployment of the Wisecow application into a Kubernetes cluster** with **secure TLS communication**.

The objective is to implement modern **DevOps practices**, including containerization, Kubernetes deployment, and secure HTTPS access.

The application runs on **port 4499** inside the container and is exposed to users through **Kubernetes Service and Ingress with TLS encryption**.

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

Flow explanation:

1. User sends HTTPS request.
2. Ingress controller handles TLS termination.
3. Traffic is forwarded to the Kubernetes service.
4. The service routes the request to the Wisecow pod running on port **4499**.

---

# Project Structure

```
wisecow-k8s
│
├── Dockerfile
├── deployment.yaml
├── service.yaml
├── ingress.yaml
└── README.md
```

---

# Step 1: Containerize the Application

Build the Docker image.

```bash
docker build -t your-dockerhub/wisecow:latest .
```

Push the image to Docker Hub.

```bash
docker push your-dockerhub/wisecow:latest
```

---

# Step 2: Create Kubernetes Deployment

`deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wisecow
spec:
  replicas: 2
  selector:
    matchLabels:
      app: wisecow
  template:
    metadata:
      labels:
        app: wisecow
    spec:
      containers:
      - name: wisecow
        image: your-dockerhub/wisecow:latest
        ports:
        - containerPort: 4499
```

Apply the deployment.

```bash
kubectl apply -f deployment.yaml
```

Verify pods:

```bash
kubectl get pods
```

---

# Step 3: Create Service

The service exposes the application inside the cluster.

`service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: wisecow-service
spec:
  selector:
    app: wisecow
  ports:
  - port: 80
    targetPort: 4499
  type: ClusterIP
```

Apply the service.

```bash
kubectl apply -f service.yaml
```

Verify:

```bash
kubectl get svc
```

---

# Step 4: Generate TLS Certificate

Generate a self-signed certificate for testing.

```bash
openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout tls.key \
-out tls.crt \
-subj "/CN=wisecow.example.com"
```

Create Kubernetes TLS secret.

```bash
kubectl create secret tls wisecow-tls \
--cert=tls.crt \
--key=tls.key
```

Verify:

```bash
kubectl get secrets
```

---

# Step 5: Configure Ingress with TLS

`ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: wisecow-ingress
spec:
  tls:
  - hosts:
    - wisecow.example.com
    secretName: wisecow-tls
  rules:
  - host: wisecow.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: wisecow-service
            port:
              number: 80
```

Apply ingress.

```bash
kubectl apply -f ingress.yaml
```

Check ingress status.

```bash
kubectl get ingress
```

---

# Step 6: Install Ingress Controller

Ingress resources require a controller.

Install **NGINX Ingress Controller**.

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

Verify controller pods.

```bash
kubectl get pods -n ingress-nginx
```

Wait until the controller is **Running**.

---

# Step 7: Configure Local DNS

Get ingress IP.

```bash
kubectl get ingress
```

Example output:

```
wisecow-ingress   wisecow.example.com   192.168.49.2
```

Add this entry to `/etc/hosts`.

```bash
sudo nano /etc/hosts
```

Add:

```
192.168.49.2   wisecow.example.com
```

---

# Step 8: Test HTTPS Access

Test using curl.

```bash
curl -k https://wisecow.example.com
```

The `-k` option ignores the self-signed certificate warning.

---

# Verification Commands

Check pods

```bash
kubectl get pods
```

Check service

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

# Key Kubernetes Concepts Used

| Component          | Purpose                          |
| ------------------ | -------------------------------- |
| Deployment         | Manages application pods         |
| Service            | Provides internal cluster access |
| Ingress            | Routes external traffic          |
| TLS Secret         | Stores SSL certificate           |
| Ingress Controller | Implements routing rules         |

---

# End Goal

The Wisecow application is successfully:

* Containerized using Docker
* Deployed on Kubernetes
* Exposed using Ingress
* Secured with TLS encryption

This demonstrates a **complete DevOps workflow for secure containerized application deployment**.
