if pgrep "/usr/sbin/nginx" > /dev/nul && pgrep "/usr/sbin/sshd" > /dev/null
then
    exit 0
else
    exit 1
fi