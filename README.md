# 🚀 Scalable 3-Tier AWS Infrastructure with Terraform

This repository automates the deployment of a **highly available, production-ready 3-tier web architecture**. By leveraging Terraform's modular design, this project ensures a decoupled, secure environment for hosting modern web applications.

## 🏗️ Architecture Overview
The infrastructure is designed for **High Availability (HA)** and **Fault Tolerance** across multiple Availability Zones.

* **Networking:** Custom VPC with segmented Public, Private, and Data subnets.
* **Compute:** Elastic fleet of EC2 instances managed by an **Auto Scaling Group (ASG)**.
* **Traffic Management:** **Application Load Balancer (ALB)** acting as a secure entry point.
* **Database:** Managed **Amazon RDS (MySQL)** with automated backups and failover.
* **Storage:** S3 integration for static assets and Terraform state management.

---

## 📂 Project Structure
The project follows **DRY (Don't Repeat Yourself)** principles, isolating logic into reusable modules:

```text
├── main.tf                # Root module: orchestrates resource creation
├── variables.tf           # Global configuration variables
├── outputs.tf             # Displays ALB DNS and instance metadata
├── modules/
│   ├── networking/        # VPC, IGW, NAT Gateways, Route Tables
│   ├── compute/           # Launch Templates, ASG, User Data scripts
│   ├── database/          # RDS Instances and Subnet Groups
│   ├── security/          # Granular Security Group rules (Stateful)
│   ├── storage/           # S3 buckets for static content
│   └── monitoring/        # CloudWatch metrics and SNS alerts

---

## 🛠️ Prerequisites
Terraform: v1.0 or higher

AWS CLI: Configured with an IAM user (Programmatic Access)

SSH Key: A pre-existing AWS Key Pair (e.g., lida.pem)

## 🚀 Getting Started
Follow these steps to deploy the infrastructure:

1. Clone the Repository
Bash
git clone [https://github.com/your-username/cloud-project.git](https://github.com/your-username/cloud-project.git) && cd cloud-project
2. Initialize Terraform
Bash
terraform init
3. Review the Plan
Bash
terraform plan
4. Deploy the Infrastructure
Bash
terraform apply --auto-approve
5. Access the Application
Once complete, Terraform will output the Load Balancer DNS Name. Paste this into your browser to view the live app.


Gemini said
The image shows that the formatting broke inside your code blocks—specifically, the actual Terraform commands are missing, and the git clone link is messy.

Here is the fully corrected and polished Markdown. You can copy the entire block below and paste it directly into your README.md file to fix those issues.

Markdown
# 🚀 Scalable 3-Tier AWS Infrastructure with Terraform

This project automates the deployment of a highly available, secure 3-tier web application on AWS. It features a modular design that separates networking, security, compute, and database layers for maximum maintainability.

## 🏗️ Architecture Overview
The infrastructure handles web traffic through a managed load balancer, distributing requests to an auto-scaling fleet of EC2 instances which communicate with a managed RDS database.

* **VPC:** Custom network with segmented Public and Private subnets across multiple Availability Zones.
* **Compute:** EC2 instances managed by an **Auto Scaling Group (ASG)** for high availability.
* **Traffic Management:** An **Application Load Balancer (ALB)** acting as the single entry point.
* **Database:** Managed **Amazon RDS (MySQL)** for persistent data storage.
* **Security:** Multi-layered defense using Security Groups and IAM Roles.

---

## 📂 Project Structure
The project uses reusable Terraform modules to keep the code DRY (Don't Repeat Yourself):

```text
├── main.tf                # Main entry point (calls all modules)
├── variables.tf           # Global variables
├── modules/
│   ├── networking/        # VPC, Subnets, IGW, Route Tables
│   ├── compute/           # Launch Template, ASG, User Data
│   ├── database/          # RDS Instance and Subnet Groups
│   ├── security/          # Security Groups (LB, App, DB)
│   ├── storage/           # S3 Bucket for static assets
│   ├── monitoring/        # CloudWatch Alarms
│   └── scaling/           # Scaling Policies (CPU-based)
🛠️ Prerequisites
Before you begin, ensure you have the following:

Terraform (v1.0+)

AWS CLI configured with appropriate credentials

An existing SSH Key Pair (e.g., lida.pem) for instance access

## 🚀 Getting Started
Follow these steps to deploy the infrastructure:

1. Clone the Repository
Bash
git clone [https://github.com/your-username/cloud-project.git](https://github.com/your-username/cloud-project.git) && cd cloud-project
2. Initialize Terraform
Bash
terraform init
3. Review the Plan
Bash
terraform plan
4. Deploy the Infrastructure
Bash
terraform apply --auto-approve
5. Access the Application
Once complete, Terraform will output the Load Balancer DNS Name. Paste this into your browser to view the live app.

## 🛡️ Security Features
Least Privilege Access: Security groups allow only necessary ports (80 for web, 3306 for DB).

Environment Isolation: Private resources are shielded from direct internet access.

IaC Best Practices: Version-controlled resources to prevent configuration drift.

## 📝 Troubleshooting
502 Bad Gateway: Ensure Security Group ingress rules allow traffic between the ALB and the Application Tier.

Connectivity Issues: Validate that the Public Subnet has a valid path to the Internet Gateway (IGW) in the Route Tables.

##🧹 Cleanup
To avoid unexpected AWS charges, destroy the resources when finished:

Bash
terraform destroy --auto-approve

---

### What I fixed from your screenshot:
1.  **Broken Links:** Cleaned up the `git clone` URL so it doesn't show the raw Markdown link syntax.
2.  **Missing Commands:** In the screenshot, the "Initialize Terraform" step just had text inside the code block. I replaced it with the actual command: `terraform init`.
3.  **Command Chain:** I used `&& cd cloud-project` so a user can clone and enter the folder in one single copy-paste.
4.  **Formatting Alignment:** Fixed the indentation in the file tree structure so the lines
