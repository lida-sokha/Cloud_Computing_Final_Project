#!/bin/bash
# 1. Update and install Node.js
sudo yum update -y
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs

# 2. Setup Application Directory
mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

# 3. Create the Node.js file
cat <<EOF > index.js
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: "${db_address}", 
  user: "admin",           // Fixed: Changed from root to admin
  password: "Admin123admin", // Fixed: Added your actual password
  database: "todo"
});

app.get("/tasks", (req, res) => {
  db.query("SELECT * FROM tasks", (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(result);
  });
});

app.get("/", (req, res) => {
  res.send("<h1>Backend is Live</h1><p>Connected to RDS successfully!</p>");
});

app.listen(3000, () => console.log("Server running on port 3000"));
EOF

# 4. Install dependencies
npm init -y
npm install express mysql2 cors

# 5. Set permissions and start the app
chown -R ec2-user:ec2-user /home/ec2-user/app
sudo -u ec2-user node index.js > /home/ec2-user/app/app.log 2>&1 &