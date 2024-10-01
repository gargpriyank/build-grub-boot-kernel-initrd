# Clone the grub repo
git clone https://git.savannah.gnu.org/git/grub.git

# Install relevant libs
dnf install gcc make bison gettext-devel binutils flex pkg-config patch libdevmapper autoconf automake

# Bootstrap the grub
./bootstrap

# Configure the grub
./configure --target=x86_64 --with-platform=efi --prefix /root/workspace/boot/grub --srcdir /root/workspace/grub

# Build the grub source
make

# Install the grub
make install

# (Optional) Copy relevant packages
cp -r /boot/grub2/fonts /root/workspace/boot/grub/lib/grub
cp -r /var/lib/tftpboot/grub/system /root/workspace/boot/grub/lib/grub
cp -r /root/workspace/boot/grub/lib/grub/x86_64-efi/* /root/workspace/boot/grub/lib/grub

# Generate grub.cfg
./grub-mkconfig -o /boot/grub2/grub.cfg

# Build .efi image
./grub-mkstandalone --verbose --directory /root/workspace/boot/grub/lib/grub/x86_64-efi --format x86_64-efi --output /var/lib/tftpboot/grub/grubx86_64.efi --disable-shim-lock --pubkey /etc/pki/tls/certs/cert_public.pem --compress xz /boot/grub/grub.cfg=/root/workspace/grub/grub.cfg /boot/grub/local_efi.cfg=/var/lib/tftpboot/grub/local_efi.cfg /boot/grub/system=/var/lib/tftpboot/grub/system /images=/var/lib/tftpboot/images /boot/grub/fonts=/var/lib/tftpboot/boot/grub2/fonts /etc/pki/tls/certs/ca-bundle.crt=/etc/pki/tls/certs/ca-bundle.crt /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
chmod 644 /var/lib/tftpboot/grub/grubx86_64.efi
