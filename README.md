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

