#!/bin/bash
 
#set -x


clear

echo "v1.1 (c) 2017 - Mirone"
echo "Credits: Micky1979"

echo ""

echo "Attention: You may not publish or Distribute this Script and 
your content without permission of the author(s)."

echo "" 

echo "This Script Requires Administrator Privileges!"

cd ~/Desktop/RepairPermissions

sudo ./InsanelyRepairPermission -rt /

echo ""
echo "Rebuild Caches:"
echo "---------------"
sudo rm -f /System/Library/Caches/com.apple.kext.caches/Startup/kernelcache 
sudo touch /System/Library/Extensions
sudo kextcache -i / 
sudo purge
sleep 1

echo ""
echo "Done!"
echo ""

# Try normal shutdown in the meantime

read -p "Restart You Computer now?(y/n)?" restart

if [[ "$restart" = "y" || "$restart" = "Y" ]]; then
	echo ""
	echo "Restarting..."
	echo "-------------"
	
	sudo shutdown -r now
	
	echo ""
	echo "Done!"
	echo ""

else 
	
	exit 1
  
  fi
 
