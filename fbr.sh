# fedora boot repair menu
echo Welcome to FBR!
PS3='Please enter your choice: '
options=("Repair GRUB" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Repair GRUB")
            # repair grub2
            echo "Repairing GRUB..."
            pkexec grub2-mkconfig -o /etc/grub2.cfg
            pkexec grub2-mkconfig -o /etc/grub2-efi.cfg
            ;;
        "Quit")
            # leave the script
	    echo "Leaving FBR..."
	    exit
	    ;;

        *) echo "invalid option.";;
    esac
done
