xzcat initrd.img | cpio -idmv
cat /etc/pki/tls/certs/ca_certificate.crt >> /root/workspace/images/orig-fs/etc/pki/tls/certs/ca-bundle.crt
find . | cpio -H newc -o | gzip -9 > /root/workspace/images/new/initrd.img
chmod 444 /var/lib/tftpboot/images/initrd.img
