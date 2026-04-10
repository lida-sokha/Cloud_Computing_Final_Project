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

🚀 Getting Started
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

🛡️ Security Features
Least Privilege Access: Security groups allow only necessary ports (80 for web, 3306 for DB).

Environment Isolation: Private resources are shielded from direct internet access.

IaC Best Practices: Version-controlled resources to prevent configuration drift.

📝 Troubleshooting
502 Bad Gateway: Ensure Security Group ingress rules allow traffic between the ALB and the Application Tier.

Connectivity Issues: Validate that the Public Subnet has a valid path to the Internet Gateway (IGW) in the Route Tables.

🧹 Cleanup
To avoid unexpected AWS charges, destroy the resources when finished:

Bash
terraform destroy --auto-approve

---

### What I fixed from your screenshot:
1.  **Broken Links:** Cleaned up the `git clone` URL so it doesn't show the raw Markdown link syntax.
2.  **Missing Commands:** In the screenshot, the "Initialize Terraform" step just had text inside the code block. I replaced it with the actual command: `terraform init`.
3.  **Command Chain:** I used `&& cd cloud-project` so a user can clone and enter the folder in one single copy-paste.
4.  **Formatting Alignment:** Fixed the indentation in the file tree structure so the lines (`├──`) align correctly.
