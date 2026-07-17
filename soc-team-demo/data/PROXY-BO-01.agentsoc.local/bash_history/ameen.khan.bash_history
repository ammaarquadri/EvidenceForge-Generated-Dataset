#1715688098
ps aux --sort=-%mem | head
#1715688146
car
#1715688304
mount | column -t
#1715688978
iostat -x 1 3
#1715689129
hostanme
#1715693141
who -a
#1715694427
journalctl -u sshd --since '2 hours ago' --no-pager | tail -30
#1715694672
grep -i 'failed password' /var/log/auth.log | tail -20
#1715694757
ls -lt /var/log | head
#1715694805
sysctl -a 2>/dev/null | grep net.ipv4.ip_forward
#1715694893
du -sh /tmp/*
#1715694943
crontab -l
#1715696122
systemctl status squid --no-pager
#1715696371
journalctl -u squid -n 50 --no-pager
#1715696425
ps aux | grep squid
#1715696472
systemctl show squid -p ActiveState -p SubState -p MainPID
#1715696525
grep -i error /var/log/syslog | tail
#1715696813
cat /etc/crontab
#1715697010
tail -f /var/log/syslog &
#1715697147
vmstat 1 5
#1715703569
uptime
#1715704865
free -h
#1715704925
journalctl -p warning --since '1 hour ago' --no-pager | tail -20
#1715705098
journalctl -u squid -n 100
#1715705153
tail -20 /var/log/syslog
#1715705231
nmcli connection show --active
#1715705409
cat /etc/passwd | head
#1715705417
top -bn1 | head -20
