# Accuknox-DevOps-Trainee-Practical-Assessment

## 🚀 Project Overview  
This repository contains solutions for two problem statements:  

1. **Containerisation and Deployment of Wisecow Application on Kubernetes**  
2. **Linux Automation Scripts (System Health Monitoring & Log Analyzer)**  

Both problem statements focus on **DevOps practices**, **containerisation**, **Kubernetes deployment**, and **automation using scripts & CI/CD pipelines**.  

---

## 📌 Problem Statement 1: Containerisation and Deployment of Wisecow Application on Kubernetes  

### 🎯 Objective  
To containerize and deploy the **Wisecow application** from [this repository](https://github.com/nyrahul/wisecow) into a Kubernetes environment, automate builds and deployments using **Jenkins & GitHub Actions/Jenkins**, and optionally enable **TLS for secure communication**.  

### 🔑 Requirements  
- **Dockerization**  
  - Create a `Dockerfile` to containerize the Wisecow application.  
  - Push the image to a container registry (Docker Hub).  

- **Kubernetes Deployment**  
  - Write Kubernetes manifests for:  
    - `Deployment` (Pod management)  
    - `Service` (expose application)  
    - `ingress`   

- **CI/CD**  
  - Github Actions pipeline to build & push Docker image.   

### 📦 Deliverables  
- `Dockerfile`  
- `Problem Statement 1/Kubernetes-Deployment/` folder with manifest files (`wisecow-deployment.yml`, `wisecow-svc.yaml`, `ingress.yaml`)  
- `ci-cd.yml`   
- Documentation on setup & deployment  

---

## 📌 Problem Statement 2: Linux Automation Scripts  

### 🎯 Objective  
Develop automation scripts for monitoring Linux systems and analyzing server logs.  

### 🔑 Requirements & Deliverables    

1. **Log File Analyzer Script**  
   - Parse Apache/Nginx logs.  
   - Extract:  
     - Count of `404 errors`  
     - Most requested pages  
     - Top IPs by request volume  
   - Output a summarized report.  

1. **Application Health Checker Script**  
   - Accepts an **application URL** as input.  
   - Uses `curl` to retrieve the HTTP status code.  
   - Verifies if the application is responding correctly.  
   - Displays the **HTTP status code** and indicates whether the application is **UP or DOWN**.

---

## ⚙️ Tech Stack  
- **Containers**: Docker  
- **Orchestration**: Kubernetes  
- **CI/CD**: Jenkins, GitHub Actions  
- **Monitoring & Analysis**: Bash / Python scripts  

---

## 🏗️ Repository Structure  

```
Accuknox-DevOps-Trainee-Practical-Assessment
│
├── Problem Statement 1
│   │
│   ├── .github
│   │   └── workflows
│   │       └── ci-cd.yml
│   │
│   ├── Kubernetes-Deployment
│   │   ├── README.md
│   │   ├── ingress.yml
│   │   ├── tls.txt
│   │   ├── wisecow-deployment.yml
│   │   └── wisecow-svc.yml
│   │
│   └── wisecow
│       ├── README.md
│       ├── wisecow.sh
│       └── Dockerfile
│
├── Problem Statement 2
│   ├── Application-HealthChecker.sh
│   ├── Log-File-Analyzer.sh
│   └── README.md
│
└── README.md

```
- [Wisecow App Repository](https://github.com/nyrahul/wisecow)  
