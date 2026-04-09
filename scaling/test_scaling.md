# Scaling Stress Test Procedure

### 1. Install Stress Tool
Connect to a running EC2 instance via SSH and run:
`sudo amazon-linux-extras install epel -y`
`sudo yum install stress -y`

### 2. Trigger Scaling
Run the following command to force the CPU to 100% for 10 minutes:
`stress --cpu 1 --timeout 600`

### 3. Verification
1. Open the **AWS EC2 Console**.
2. Navigate to **Auto Scaling Groups** -> **Activity History**.
3. Capture a screenshot when a new instance status changes to "InService."