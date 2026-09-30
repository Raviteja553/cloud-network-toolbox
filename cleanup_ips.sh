#!/bin/bash

echo "1. Scanning subscription for unassociated Public IP addresses..."

# Query all Public IPs where 'ipConfiguration' is null (i.e., not attached to any resource)
ORPHANED_IPS=$(az network public-ip list \
  --query "[?ipConfiguration==null].{Name:name, ResourceGroup:resourceGroup, ID:id}" \
  --output json)

# Check if any unattached IPs were found
COUNT=$(echo "$ORPHANED_IPS" | jq '. | length')

if [ "$COUNT" -eq 0 ]; then
    echo "No unassociated Public IPs found."
else
    echo "Found $COUNT unassociated Public IP(s). Starting cleanup..."
    
    # Loop through each orphaned IP and delete it
    echo "$ORPHANED_IPS" | jq -c '.[]' | while read -r ip; do
        NAME=$(echo "$ip" | jq -r '.Name')
        RG=$(echo "$ip" | jq -r '.ResourceGroup')
        
        echo "Deleting orphaned Public IP: $NAME from Resource Group: $RG..."
        az network public-ip delete --resource-group "$RG" --name "$NAME"
        echo "Successfully deleted $NAME."
    done
fi