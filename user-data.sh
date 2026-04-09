#!/bin/bash
# 1. Update and install Node.js
sudo yum update -y
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# 2. Install CloudWatch Agent
sudo yum install -y amazon-cloudwatch-agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config -m ec2 -s -c default

# 3. Setup Application Directory
mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

# 4. Create the Node.js file
cat <<EOF > index.js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: "${db_address}", 
  user: "root",           
  password: "", // 
  database: "todo"
});

app.get("/tasks", (req, res) => {
  db.query("SELECT * FROM tasks", (err, result) => {
    if (err) return res.status(500).send(err);
    res.json(result);
  });
});

app.get("/", (req, res) => {
  res.send("<h1>Backend is Live</h1><p>Connected to: ${db_address}</p>");
});

app.listen(3000, () => console.log("Server running on port 3000"));
EOF

npm init -y
npm install express mysql2 cors

chown -R ec2-user:ec2-user /home/ec2-user/app

sudo -u ec2-user node index.js > /home/ec2-user/app/app.log 2>&1 &