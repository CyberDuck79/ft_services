mkdir -p /ftps/$FTP_USER
adduser -h /ftps/$FTP_USER -D $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd
chown $FTP_USER:$FTP_USER /ftps/$FTP_USER
/usr/sbin/vsftpd -opasv_min_port=21000 -opasv_max_port=21010 -opasv_address=IP10 /etc/vsftpd/vsftpd.conf