# Netflix app-v-2.8 Project

This project is a sample Netflix-style web application.  
This README explains **how to host the project on an Apache server** (Ubuntu/Linux EC2).

---

## Table of Contents

1. [Project Structure](#project-structure)  
2. [Prerequisites](#prerequisites)  
3. [Deployment Steps](#deployment-steps)  
4. [Access the Application](#access-the-application)  
5. [Permissions & Notes](#permissions--notes)

---

## Project Structure

```

Netflix-app-v-2.8-Project/
├── pom.xml
├── Script
└── src/
├── main/
│   ├── java/      # Java source code (not used directly for Apache hosting)
│   └── webapp/
│       ├── index.jsp
│       ├── style.css
│       └── WEB-INF/
└── test/

````

> **Note:** Apache will serve files directly from `webapp`.

---

## Prerequisites

- Ubuntu EC2 instance
- Apache installed (`sudo apt install apache2`)
- Git installed (`sudo apt install git`)
- Browser to access EC2 public IP

---

## Deployment Steps (Apache-only)

### 1️⃣ Clone the repository

```bash
cd /var/www/html
git clone https://github.com/Shaik-DevOpsLucky/Netflix-Project.git
cd Netflix-app-v-2.8-Project/src/main/webapp
````

### 2️⃣ Configure Apache

Edit the default site configuration:

```bash
sudo vi /etc/apache2/sites-enabled/000-default.conf
```

Update it as:

```apache
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/Netflix-app-v-2.8-Project/src/main/webapp

    <Directory /var/www/html/Netflix-app-v-2.8-Project/src/main/webapp>
        Options FollowSymLinks
        AllowOverride None
        Require all granted
        DirectoryIndex index.jsp index.html
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

> **Important:** `DocumentRoot` must point to the **directory**, not `index.jsp`.
## /var/www/html/Netflix-app-v-2.8-Project/src/main/webapp/
---

### 3️⃣ Restart Apache

```bash
sudo systemctl restart apache2
```

---

### 4️⃣ Verify Permissions (optional):

```bash
sudo chown -R www-data:www-data /var/www/html/Netflix-app-v-2.8-Project
sudo chmod -R 755 /var/www/html/Netflix-app-v-2.8-Project
```

---

## Access the Application

Open your browser:

```
http://<EC2-PUBLIC-IP>/
```
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1e79651e-193e-47b1-96e4-526fa6d3befa" />

## Notes & Tips

* Apache **cannot run Java logic fully** like Tomcat, but will render JSP pages for simple projects.
* Always ensure `index.jsp` exists for the default page.
* Keep the `webapp` directory structure intact for proper file references (CSS/JS).
* Optional: disable directory listing globally in Apache:

---

## 🐳 Docker Build & Push to AWS ECR (Steps Only)

This section explains how to **build the Docker image** and **push it to AWS Elastic Container Registry (ECR)** using the existing `Dockerfile`.

---

### 1️⃣ Build Docker Image

From the project root directory:

```bash
docker build -t netflix-app-v-2.8 .
```

Verify the image:

```bash
docker images
```

---

### 2️⃣ Test Docker Image Locally (Optional)

```bash
docker run -d --name netflix-app -p 8080:8080 netflix-app-v-2.8
```

Access:

```
http://<IP>:8080
```

---

## ☁️ Push Docker Image to AWS ECR

### 3️⃣ Create ECR Repository

```bash
aws ecr create-repository \
  --repository-name netflix-app-v-2.8 \
  --region us-east-1
```

Copy the repository URI returned by AWS.

---

### 4️⃣ Authenticate Docker to ECR

```bash
aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
```

---

### 5️⃣ Tag Docker Image

```bash
docker tag netflix-app-v-2.8:latest \
<AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/netflix-app-v-2.8:latest
```

---

### 6️⃣ Push Docker Image to ECR

```bash
docker push \
<AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/netflix-app-v-2.8:latest
```

---

## ✅ Result

* Docker image successfully built
* Image pushed to **AWS ECR**
* Ready for deployment on **EC2 / ECS / EKS**

---

## 🔍 Quick Notes

* Ensure AWS CLI is configured:

```bash
aws configure
```

* Docker must be running
* Correct IAM permissions are required for ECR

---

# Prepared by:
*Shaik Moulali*


