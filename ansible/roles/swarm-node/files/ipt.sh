#!/bin/sh
echo "Stopping firewall and allowing everyone..."
ipt="/sbin/iptables"
## Failsafe - die if /sbin/iptables not found 
echo "Stopping firewall and allowing everyone..."
[ ! -x "$ipt" ] && { echo "$0: \"${ipt}\" command not found."; exit 1; }
echo "Stopping firewall and allowing everyone..."
$ipt -P INPUT ACCEPT
echo "Stopping firewall and allowing everyone..."
$ipt -P FORWARD ACCEPT
echo "Stopping firewall and allowing everyone..."
$ipt -P OUTPUT ACCEPT
echo "Stopping firewall and allowing everyone..."
$ipt -F
echo "Stopping firewall and allowing everyone..."
$ipt -X
$ipt -t nat -F
$ipt -t nat -X
$ipt -t mangle -F
$ipt -t mangle -X
$ipt -t raw -F
$ipt -t raw -X

