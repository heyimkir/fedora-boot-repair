# fedora boot repair menu
echo Welcome to FBR!
echo FBR Version: v1.1
echo Disclaimer: if you are running on a Live USB, CHROOT INTO YOUR HARD DRIVE FIRST
PS3='Please enter your choice:'
options=("Repair GRUB" "Reinstall GRUB UEFI" "Reinstall GRUB MBR" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Repair GRUB")
            # repair grub2
            echo "Repairing GRUB..."
            pkexec grub2-mkconfig -o /etc/grub2.cfg
            pkexec grub2-mkconfig -o /etc/grub2-efi.cfg
            clear
            ;;
        "Reinstall GRUB UEFI")
            echo This will reinstall the GRUB Bootloader.
            read -p "Press enter to continue."
            sudo rm /boot/efi/EFI/fedora/grub.cfg
            sudo rm /boot/grub2/grub.cfg
            sudo dnf reinstall shim-* grub2-efi-* grub2-common
            clear
            ;;
        "Reinstall GRUB MBR")
        	echo This will reinstall the GRUB Bootloader.
        	read -p "Press enter to continue"
        	echo Please specify the /dev the root of your broken grub is on
        	echo WITHOUT the number example: /dev/sda.
        	read devnode
        	echo Reinstalling GRUB...
        	sudo grub2-install $devnode
        	clear
        	;;
        	
        "Quit")
            
	    echo "Leaving FBR..."
	    exit
	    ;;

        *) echo "invalid option.";;
    esac
done
