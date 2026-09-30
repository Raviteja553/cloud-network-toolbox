# Cloud Network Toolbox

A modular collection of Cloud Network Engineering automation scripts, Azure CLI diagnostic utilities, and a containerized network connectivity test suite.

---

## 📁 Repository Structure

- **`cleanup_ips.sh`** – Bash script utilizing Azure CLI and `jq` to identify and purge unassociated/orphaned Standard Public IPs across subscriptions to optimize cloud spending.
- **`get_effective_routes.sh`** – Azure CLI utility to query and display the effective routing table for a specified Virtual Machine Network Interface (NIC).
- **`test_connectivity.sh`** – Multi-stage automated network diagnostic suite verifying DNS resolution (`dig`), ICMP reachability (`ping`), and HTTP/HTTPS status codes (`curl`).
- **`Dockerfile`** – Alpine Linux-based container image pre-packaged with essential network tools (`dig`, `curl`, `iproute2`, `traceroute`, `tcpdump`, `iputils`).

---

## 🚀 Usage & Execution

1. Azure Public IP Cleanup
Identifies and deletes unassociated Public IPs:
```bash
./cleanup_ips.sh

2. Azure Effective Route Table Extractor
Extracts active routing table for a target VM:

Bash
./get_effective_routes.sh <ResourceGroupName> <VMName>
3. Containerized Diagnostic Suite
Build and run the Alpine Linux network diagnostic suite locally via Docker:

Bash
# Build the Docker image
docker build -t cloud-network-toolbox:v1 .

# Run the diagnostic test suite
docker run --rm cloud-network-toolbox:v1

🛠️ Tech Stack & Prerequisites
Cloud Platform: Azure CLI (az)

Scripting & Shell: Bash, jq, iproute2, bind-tools

Containerization: Docker Desktop / Alpine Linux / WSL 2

Version Control: Git (master branch workflow)