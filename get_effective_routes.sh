#!/bin/bash
# Fetch effective route table for a VM network interface
RESOURCE_GROUP=${1:-"rg-network-test"}
VM_NAME=${2:-"vm-network-node"}

echo "Querying effective routes for $VM_NAME in $RESOURCE_GROUP..."
az network nic show-effective-route-table --resource-group "$RESOURCE_GROUP" --name "${VM_NAME}-nic" --output table
