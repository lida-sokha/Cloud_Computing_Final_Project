#!/bin/bash
# 1. Update the system
sudo yum update -y

# 2. Install the CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent

# 3. Start the agent with a default configuration
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config -m ec2 -s -c default

# 4. (Optional) Your web server setup
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Welcome to Project Cloud!</h1>" > /var/www/html/index.html