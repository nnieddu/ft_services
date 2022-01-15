echo "admin" > /etc/vsftpd/vsftpd.userlist

adduser -D -g "admin" admin
echo "admin:admin" | chpasswd
mkdir /home/admin/ftp
chown admin:admin /home/admin
chown admin:admin /home/admin/ftp

echo "Ceci est un fichier de test" >> /home/admin/ftp/testfile

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj '/C=FR/ST=FR/L=null/O=null/CN=null' \
-keyout /etc/ssl/certs/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

vsftpd /etc/vsftpd/vsftpd.conf