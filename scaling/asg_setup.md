# Auto Scaling Group (ASG) Configuration

### 1. Group Size Settings
- **Minimum Capacity:** 1 (Ensures the app is never completely down)
- **Desired Capacity:** 2 (Standard running state for high availability)
- **Maximum Capacity:** 4 (Limit to prevent runaway costs during high traffic)

### 2. Launch Template
The ASG uses a Launch Template that includes:
- **AMI:** Amazon Linux 2 (Optimized for AWS)
- **Instance Type:** t2.micro (Free Tier eligible)
- **Security Group:** Configured to allow traffic only from the Load Balancer.