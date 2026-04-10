🚀 Scalable 3-Tier AWS Infrastructure with Terraform
This project automates the deployment of a highly available, secure 3-tier web application on AWS using Terraform. It features a modular design that separates networking, security, compute, and database layers for maximum maintainability.

🏗️ Architecture Overview
The infrastructure is designed to handle web traffic through a managed load balancer, distributing requests to an auto-scaling fleet of EC2 instances, which then communicate with a managed RDS database.

Virtual Private Cloud (VPC): Custom network with segmented Public and Private subnets across multiple Availability Zones.

Compute: EC2 instances managed by an Auto Scaling Group (ASG) to ensure high availability and self-healing.

Traffic Management: An Application Load Balancer (ALB) acting as a single entry point for user traffic.

Database: A managed Amazon RDS (MySQL) instance for persistent data storage.

Security: Multi-layered defense using Security Groups (acting as virtual firewalls) and IAM Roles.

## 📂 Project Structure

The project is organized into reusable Terraform modules for better maintainability:

```text
├── main.tf                # Main entry point (calls all modules)
├── variables.tf           # Global variables
├── modules/
│   ├── networking/        # VPC, Subnets, Internet Gateway, Route Tables
│   ├── compute/           # Launch Template, ASG, User Data
│   ├── database/          # RDS Instance and Subnet Groups
│   ├── security/          # Security Groups for LB, App, and DB
│   ├── storage/           # S3 Bucket for static assets
│   ├── monitoring/        # CloudWatch Alarms
│   └── scaling/           # Scaling Policies (CPU-based)


🛠️ Prerequisites
Terraform (v1.0+)

AWS CLI configured with appropriate credentials

An existing SSH Key Pair (e.g., lida.pem) for instance access

## 🚀 Getting Started

Follow these steps to deploy the infrastructure:

### 1. Clone the Repository
```bash
git clone [https://github.com/your-username/cloud-project.git](https://github.com/your-username/cloud-project.git) && cd cloud-project

## 2. Initialize Terraform
This command downloads the required providers and sets up the backend.
```bash
Initialize Terraform

## 3. Review the Plan
It is best practice to see exactly what resources Terraform will create.
```bash
terraform plan

## 4. Deploy the Infrastructure
Run this to provision your cloud resources.
```bash
terraform apply --auto-approve
---

### 💡 Extra Polish for your README
Since this is a Cloud/Terraform project, you might want to add a **Cleanup** section right below it. This helps people avoid getting charged by their cloud provider if they forget to turn things off!

```markdown
### 🧹 Cleanup
To delete all resources created by this project and avoid costs:
```bash
terraform destroy --auto-approve

5.Access the Application:
Once the deployment is complete, Terraform will output the Load Balancer DNS Name. Paste this into your browser to view the live app.

🛡️ Security Features
Least Privilege Access: Security groups are configured to only allow necessary ports (80 for web, 3000 for app, 3306 for DB).

Infrastructure as Code (IaC): Every resource is version-controlled, preventing "configuration drift" and allowing for rapid disaster recovery.

Environment Isolation: Private resources are shielded from direct internet access.

📝 Troubleshooting & Lessons Learned
During development, we successfully resolved common cloud challenges:

502 Bad Gateway: Fixed by aligning Security Group ingress rules to allow traffic between the Load Balancer and the Application Tier.

Connectivity: Validated Route Tables to ensure the Public Subnet had a valid path to the Internet Gateway.

