# ASUS Zephyrus-M Hackintosh
Personal project to install Mac OS High Sierra in the ASUS Zephyrus-M GM501GS consolidating guides from different forums.

- OS: Mac OS High Sierra 10.13.6
- CPU i7 8750H Code Lake
- Chipset: HM370
- Graphics: NVIDIA GTX 1070 8GB GDDR5
- Wi-Fi: Intel Wireless-AC 9560
- Bluetooth: HCI 9.256 / LMP 9.256
- Camera: USB2.0 HD UVC WebCam
- Audio/Mic: Realtek HD Audio ALC3328 (ALC294 codec)
- Keyboard & Trackpad - ELAN/SA473I-12A4

All softwares/files/steps in the repository are downloaded from other websites/forums and owned by their creators.

Recommended websites for more information/support:
- https://www.olarila.com/
- https://www.tonymacx86.com/
- https://www.insanelymac.com/
- https://www.reddit.com/r/hackintosh/

Thanks to everyone that helped me answering questions and sharing the knowledge, specially RehabMan, Mald0n and Mirone

Caveats:
NVIDIA Optimus isn't compatible with MacOS so you will only be able to use the NVIDIA GPU not the Intel.
Intel Wi-Fi isn't compatible with MacOS so to have wi-fi you need to buy a compatible Wi-Fi USB Adapter, I recommend the Foktech Wifi Dongle, AC600 802.11ac Dual Band 5GHz Mini Wireless Network USB

STEP 0 - Create your USB Installer

There are two ways to do that:
a) Download a custom image, I recommend using the image fro Olarila that can be downloaded here: https://olarila.com/forum/viewtopic.php?f=51&t=6393

The image you will need is the one for Intel 8th Generation

You can write it to a USB using the Etcher app: https://www.balena.io/etcher/

b) Create your own image:

1) Using a MacOS, download High Sierra in the AppStore
2) Download Unibeast and follow the steps to prepare the Installation USB
3) If Unibeast gives an error saying that the Installer couldn't be created it's because you didn't download the full installer, open the High Sierra application and wait for it to finish downloading. When asked to restart, just close the installer.
4) Open Terminal and type:

sudo -s
mkdir /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport
cd /macOS\ Install\ Data
find . -mount | cpio -pvdm /Applications/Install\ macOS\ High\ Sierra.app/Contents/SharedSupport
xar -xf InstallESDDmg.pkg InstallESD.dmg 

More info on this can be found on TonyMacx86 forum: https://www.tonymacx86.com/threads/fix-solution-for-selected-mac-os-x-installer-is-incomplete.249330/

In order to boot the Clover from the USB, you should access your BIOS settings:
- "VT-d" (virtualization for directed i/o) should be disabled if possible (the config.plist includes dart=0 in case you can't do this)
- "DEP" (data execution prevention) should be enabled for OS X
- "secure boot " should be disabled
- "legacy boot" optional (recommend enabled, but boot UEFI if you have it)
- "CSM" (compatibility support module) enabled or disabled (varies) (recommend enabled, but boot UEFI)
- "fast boot" (if available) should be disabled.
- "boot from USB" or "boot from external" enabled
- SATA mode (if available) should be AHCI

STEP 1 - update BIOS
Open the BIOS, go to Advanced options and:
Disable Fastboot
Disable Secure Boot
Disable VT-D

STEP 2 - Create MacOS Partition:

It's highly recommended to install MacOS on the M2 partition since it's much faster. For that you need to open the Disk Management tool from Windows shrink Partition on Disk 1 (256GB) to create a new partition for MacOS
Format this Partition as FAT32

STEP 4 - Install Mac OS
Boot with the USB disk and press/hold ESC when the Republic of Gamers is displayed. Select your USB and then select Boot macOS Install from Install macOS High Sierra
Open Disk Utility and format the MacOS Partition as Mac OS Journaled
Start the installation of Mac OS in this partition
The computer will restart a couple of times during the installation, every time it restarts you will need to go to the Boot menu, choose the USB and then select Boot macOS Install from your new MacOS partition (not from the USB Install Tool)

Troubleshoot in case the Mac OS installation don't let you install it on the new partition:
You will need to increase the EFI partition size in order to proceed with the installation

Using the Disk Management tool from Windows delete the newly created Mac Partition

Using Diskpart create a new EFI partition
Open CMD using Admin rights and type the following code:
-> Diskpart
-> List Disk
-> Sel disk x (x should be the number of the HDD where Windows is installed)
-> Create partition efi size=400
-> format quick fs=fat32 label="System"
-> List Vol
-> Sel vol x (x should be the number of your new 400MB System partition)
-> assign letter=v

Close Diskpart and then type on CMD
-> bcdboot c:\windows /s v: /f ALL

Now open MacDrive again and re-create the MacOS partition with the remaining space in the hard-disk

-> For more info on creating an EFI partition, please check crazyboy24's guide: https://www.tonymacx86.com/threads/guide-solving-media-kit-reports-not-enough-space-on-device-for-requested-operation-error.168286/

STEP 5 - Run MacOS and install VGA drivers
Once MacOS is installed you can restart the computer, boot via the USB and select Boot macOS from your new MacOS Partition. (DO NOT SELECT THE OS INSTALLATION AGAIN, SELECT TO BOOT MACOS FROM YOUR HD)
Now it's time to install the Wi-Fi drivers from your Wi-Fi adapter (remember that the on-board Intel chipset isn't supported by MacOS so you need to use a compatible USB Wi-Fi adapter)
After installing the wi-fi and restarting your Mac you need to install the Nvidia Web Drivers, for that the easiest way is to use a handy patcher made by Benjamin Dobell (https://github.com/Benjamin-Dobell/nvidia-update)

Just open terminal and type: bash <(curl -s https://raw.githubusercontent.com/Benjamin-Dobell/nvidia-update/master/nvidia-update.sh)

This will find the best version, download and install it for you. Once installed, restart the computer

Troubleshoot in case the NVIDIA Web Drivers installation gives an error saying that your OS is not compatible:
You will need to do a few tweaks to make it work:
1) Check what is the latest supported OS code for that Web Driver
2) Open you SystemVersion.plist file inside CoreServices (FIND IT) and tweak your OS Code to match the NVIDIA one (make a backup first)
3) Install the Web Driver and don't restart
4) Go to /Library/Extensions and open the package contents of NVDAStartup.kext
5) Tweak info.plist to the OS Code of your OS
6) Now revert the Systemversion tweak back to the original version that you made a backup
7) Use RepairPermissions to repair the permissions fo the kext
8) Open the Nvidia Driver Managet tool and enable the NVIDA Web Driver - if not available restart your computer and then enable it.
8) Restart your computer

STEP 6 - Install Clover to boot without the USB
Now that you have the Mac OS installed and working as expected, we need to install Clover in our main EFI partition for that so you can stop using the USB to boot. First install Clover Configurator, open it and select Mount EFI. You should mount the EFI partition from the Windows disk, it should be called SYSTEM.
Open the partition and replace the folder EFI entirely with the new EFI folder from the repository.

STEP 7 - Fix AppleHDA
Download the patched HDA from the repository and place it on System/Library/Extensions deleting the previous version
Download the RepairPermissions folder, put on your desktop and then run Repair.command
Restart the computer, once restarted you should have the sound device enabled

STEP 8 - Add Boot options in the BIOS to boot Windows
Boot the computer, access the BIOS and go to Boot Settings.
Add a new Boot Option called Windows 10 and select the file /EFI/Microsoft/Boot/bootmgfw-org.efi to load
If you want Windows to be your default OS leave this as the 1st boot option, otherwise leave "Windows Boot Manager" or "clover.efi boot menu" as the primary

STEP 9 - Brightness Slider
There's no native support for changing the Brightness options so go to the AppStore and download the app Brightness Slider

STEP 10 - Re-map CMD keys - optional
I personally recommend installing the software Karabiner to map the keys on your keyboard to be closer to what you use on Windows so I've mapped ALT to be the Command Key from Mac, for that I've added the config left_alt to left_gui and left_gui to left_alt.

STEP 11 - Extra mouse buttons - optional
If you are using a mouse with additional buttons and want to replicate the Back function from Windows you can do that installing this app: https://sensible-side-buttons.archagon.net