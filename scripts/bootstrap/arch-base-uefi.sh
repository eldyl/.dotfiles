#!/bin/bash

# Variables
hostname=""
root_password=""
username=""
user_password=""
tz="America/Los_Angeles"

ln -sf "/usr/share/zoneinfo/$tz" /etc/localtime
hwclock --systohc
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "$hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts
echo "root:$root_password" | chpasswd

pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet \
    dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi \
    xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez \
    bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse  \
    pipewire-jack git bash-completion openssh rsync reflector acpi acpi_call \
    virt-manager qemu edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat \
    ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g \
    wireguard-tools veracrypt unrar rclone timeshift cronie

## CPU Microcode
# pacman -S --no-confirm amd-ucode
# pacman -S --no-confirm intel-ucode

## GPU Drivers
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# sed -i '/GRUB_ENABLE_CRYPTODISK=y/s/^#//g' /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable cronie

useradd -m "$username"
echo "$username:$user_password" | chpasswd
usermod -aG libvirt "$username"

echo "$username ALL=(ALL) ALL" >> "/etc/sudoers.d/$username"

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
