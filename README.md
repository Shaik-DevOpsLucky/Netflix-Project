# Netflix Pipeline Project

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

Netflix-Pipeline-Project/
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
cd Netflix-Pipeline-Project/src/main/webapp
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
    DocumentRoot /var/www/html/Netflix-Pipeline-Project/src/main/webapp

    <Directory /var/www/html/Netflix-Pipeline-Project/src/main/webapp>
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
## /var/www/html/Netflix-Pipeline-Project/src/main/webapp/
---

### 3️⃣ Restart Apache

```bash
sudo systemctl restart apache2
```

---

### 4️⃣ Verify Permissions (optional):

```bash
sudo chown -R www-data:www-data /var/www/html/Netflix-Pipeline-Project
sudo chmod -R 755 /var/www/html/Netflix-Pipeline-Project
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

# Prepared by:
*Shaik Moulali*


