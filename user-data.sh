#!/bin/bash
# 1. Update the system
sudo yum update -y

# 2. Install the CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent

# 3. Start the agent with a default configuration
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config -m ec2 -s -c default

# 4. Install and start Web Server
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# 5. Create a dynamic landing page showing the DB Connection
# Note: ${db_address} is replaced by Terraform at runtime
cat <<EOF > /var/www/html/index.html
<html>
<head><title>Project Cloud</title></head>
<body>
  <h1>Welcome to Project Cloud!</h1>
  <p><strong>Server Status:</strong> Online</p>
  <p><strong>Connected Database:</strong> ${db_address}</p>
</body>
</html>
EOF