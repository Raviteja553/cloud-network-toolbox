#!/bin/bash

# Cloud Network Toolbox - Effective Route Extractor
# Usage: ./get_effective_routes.sh <ResourceGroup> <VMName>

RESOURCE_GROUP=${1:-"rg-network-test"}
VM_NAME=${2:-"vm-network-node"}

echo "=========================================="
echo " Querying Azure Effective Route Table"
echo " Resource Group: $RESOURCE_GROUP"
echo " VM Name:        $VM_NAME"
echo "=========================================="

# Fetch Network Interface ID associated with VM
NIC_ID=$(az vm show -g "$RESOURCE_GROUP" -n "$VM_NAME" --query "networkProfile.networkInterfaces[0].id" -o tsv 2>/dev/null)

if [ -z "$NIC_ID" ]; then
    echo "Error: Could not retrieve NIC for VM '$VM_NAME' in Resource Group '$RESOURCE_GROUP'."
    exit 1
fi

NIC_NAME=$(basename "$NIC_ID")
echo "Found attached NIC: $NIC_NAME"
echo "Fetching effective routes..."
echo ""

az network nic show-effective-route-table --resource-group "$RESOURCE_GROUP" --name "$NIC_NAME" --output table
