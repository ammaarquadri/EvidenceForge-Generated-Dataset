#1715691120
systemctl is-active php-fpm
#1715691177
journalctl -u sshd --since '30 min ago' --no-pager | tail -50
#1715691250
ss -ltnp | grep nginx
#1715691581
systemctl show nginx -p ActiveState -p SubState -p MainPID
#1715691649
systemctl restart nginx
#1715691677
uptime
#1715691705
cta
#1715691746
exit
#1715691817
systemctl list-units --failed
#1715691883
journalctl --since '10 min ago' --no-pager -n 20
#1715697088
systemctl is-active sshd
#1715697361
journalctl -u sshd -n 50 --no-pager
#1715697587
ps aux | grep php-fpm
#1715697978
systemctl cat sshd 2>/dev/null | head -40
#1715698092
iptables -L -n
#1715698831
du -sh /var/log/*
#1715700927
systemctl is-active php-fpm
#1715701146
journalctl -u sshd --since '30 min ago' --no-pager | tail -100
#1715701386
ss -ltnp | grep php-fpm
#1715701395
systemctl show php-fpm -p ActiveState -p SubState -p MainPID
#1715701491
loginctl list-sessions
#1715701626
timedatectl
#1715701872
ss -tan | head
#1715701957
systemd-analyze blame | head
#1715701967
resolvectl query login.microsoftonline.com
#1715702078
ip -br addr
#1715703474
free -m
#1715703547
ss -ltnp | grep nginx
#1715703558
exit
#1715703633
systemctl status php-fpm --no-pager
#1715703643
journalctl -u nginx -n 20 --no-pager
#1715703665
ps aux | grep sshd
#1715703912
systemctl show nginx -p ActiveState -p SubState -p MainPID
#1715703933
ls -ltr /var/log/ | tail -10
#1715703965
le
#1715704130
ls /var/log
#1715704167
ps aux
#1715704174
ls -lh
#1715704246
systemctl list-timers --all --no-pager | head
#1715704299
ps aux | grep nginx
#1715704361
grep -i 'failed password' /var/log/auth.log | wc -l
#1715704436
iostat -x 1 3
#1715704527
id
#1715704586
ls -lah /tmp | head
#1715704647
mount | column -t
#1715704837
ll
#1715704877
loginctl user-status
#1715705089
find /var/log -name '*.gz' -mtime +30 | wc -l
#1715705154
systemctl status sshd
#1715705221
ip route
#1715706099
who -a
#1715706195
cd ~
#1715706207
apt list --upgradable 2>/dev/null
#1715706253
systemctl list-units --failed
#1715706297
ps -ef
#1715706650
resolvectl query login.microsoftonline.com
#1715706705
stat /etc/passwd
#1715707011
systemctl status NetworkManager --no-pager
#1715707111
env | sort | head
#1715707180
cd /tmp
#1715707233
loginctl list-sessions
#1715707256
df -h /var
