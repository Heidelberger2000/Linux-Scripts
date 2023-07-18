#!/bin/sh


proxmox-backup-client backup etc.pxar:/etc/pve/lxc/ --repository 10.24.99.20:backup --ns ProxmoxVE-Config --backup-id lxc-clients
sleep 2
proxmox-backup-client backup etc.pxar:/etc/pve/qemu-server/ --repository 10.24.99.20:backup --ns ProxmoxVE-Config --backup-id qemu-clients
sleep 2
proxmox-backup-client backup etc.pxar:/etc/ --repository 10.24.99.20:backup --ns ProxmoxVE-Config --backup-id VE-config
