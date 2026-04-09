# Dynamic Scaling Policy

### Target Tracking Policy
We use CPU utilization to trigger scaling events to handle high traffic:
- **Metric:** `AWS/EC2: CPUUtilization`
- **Target Value:** 50%
- **Cooldown:** 300 seconds

**Logic:** If the average CPU across all servers goes above 50%, a new instance is launched automatically. Once the load drops back down, the extra instance is removed to save costs.