/usr/bin/ssh-keygen -A

adduser -D $SSH_USER
echo "$SSH_USER:$SSH_PASS" | chpasswd

/usr/sbin/sshd
/usr/sbin/nginx -g "daemon off;"