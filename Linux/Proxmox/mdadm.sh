apt update
apt install mdadm
modprobe -a md linear multipath raid0 raid1 raid5 raid6 raid10

# RAID erstellen

## RAID1
## mdadm --create --verbose /dev/md0 --auto=yes --level=1 --raid-devices=2 /dev/sdb /dev/sdc

## RAID5
## mdadm --create --verbose /dev/md1 --auto=yes --level=5 --raid-devices=3 /dev/sdd /dev/sde /dev/sdf

# RAID Details
# mdadm --detail /dev/md(Nummer)

# Dateisystem anlegen und Volume mounten
# mkfs.(Dateisystem) /dev/md(Nummer)

# Mountpoint anlegen
# mkdir /mnt/pve/(ordner)

# Mounten
# mount -t (Dateisystem) /dev/md(Nummer) /mnt/pve/(ordner)

# Platte hinzufügen
# mdadm --manage /dev/md(nummer) --add /dev/(device)

# RAID löschen
# unmount /dev/md0
# mdadm --stop /dev/md0
# mdadm --zero-superblock /dev/sd[b-c]
# mdadm --detail /dev/md0
