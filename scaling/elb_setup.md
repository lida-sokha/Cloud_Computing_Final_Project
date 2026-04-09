# Application Load Balancer (ALB) Setup

### 1. Listener Rules
- **Protocol:** HTTP
- **Port:** 80
- **Action:** Forward traffic to the `todo-app-target-group`.

### 2. Health Checks
- **Path:** /
- **Threshold:** 2 healthy checks to stay in service.
- **Interval:** 30 seconds.
- **Purpose:** Automatically stops sending traffic to any server that crashes.