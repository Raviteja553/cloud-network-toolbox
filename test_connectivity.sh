#!/bin/bash

TARGET_DNS=${1:-"azure.microsoft.com"}
TARGET_IP=${2:-"8.8.8.8"}

echo "--------------------------------------------------"
echo " Running Automated Network Diagnostic Suite"
echo " Target DNS: $TARGET_DNS | Target IP: $TARGET_IP"
echo "--------------------------------------------------"

echo "[1/3] Testing DNS Resolution..."
dig +short "$TARGET_DNS"
if [ $? -eq 0 ]; then
    echo "=> DNS Resolution: SUCCESS"
else
    echo "=> DNS Resolution: FAILED"
fi
echo ""

echo "[2/3] Testing ICMP Reachability..."
ping -c 3 "$TARGET_IP" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "=> ICMP Ping: SUCCESS"
else
    echo "=> ICMP Ping: FAILED"
fi
echo ""

echo "[3/3] Testing HTTP/HTTPS Reachability..."
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "https://$TARGET_DNS")
echo "=> HTTP Response Code for https://$TARGET_DNS: $HTTP_STATUS"

echo "--------------------------------------------------"
echo " Diagnostic Suite Complete"
echo "--------------------------------------------------"
