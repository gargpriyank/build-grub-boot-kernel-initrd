#Rebuild initrd.img with newly added CA certificate
xzcat initrd.img | cpio -idmv
cat /etc/pki/tls/certs/ca_certificate.crt >> /root/workspace/images/orig-fs/etc/pki/tls/certs/ca-bundle.crt
find . | cpio -H newc -o | gzip -9 > /root/workspace/images/new/initrd.img
cp /root/workspace/images/new/initrd.img /var/lib/tftpboot/images
chmod 444 /var/lib/tftpboot/images/initrd.img

#Add below in the kickstart just before the url. This will install the newly added certificate
%pre
update-ca-trust
%end
