apt update
apt install mdadm
modprobe -a md linear multipath raid0 raid1 raid5 raid6 raid10

# RAID erstellen (exemplarisch MD0)

## RAID1
## mdadm --create --verbose /dev/md0 --auto=yes --level=1 --raid-devices=2 /dev/sdb /dev/sdc

## RAID5
## mdadm --create --verbose /dev/md0 --auto=yes --level=5 --raid-devices=3 /dev/sdd /dev/sde /dev/sdf

# RAID Details
# mdadm --detail /dev/md0

# Dateisystem anlegen und Volume mounten
# mkfs.ext4 /dev/md0

# Mountpoint anlegen
# mkdir /mnt/pve/MD0

# Mounten
# mount -t ext4 /dev/md0 /mnt/pve/MD0

# Platte hinzufügen
# mdadm --manage /dev/md0 --add /dev/(device)

# RAID löschen
# umount /mnt/pve/MD0
# unmount /dev/md0
# mdadm --stop /dev/md0
# mdadm --zero-superblock /dev/sd[b-c]
# mdadm --detail /dev/md0
