#1715696286
ip route get 8.8.8.8
#1715696747
ip -o addr show scope global
#1715696800
lsblk
#1715696808
grep -i 'failed password' /var/log/auth.log | wc -l
#1715696855
tail -f /var/log/syslog &
#1715696973
umask
#1715697150
grep -i failed /var/log/auth.log | tail
#1715697230
stat /etc/passwd
#1715697484
du -sh /var/log/*
#1715697614
journalctl -u NetworkManager --since '2 hours ago' --no-pager | tail -30
#1715697995
crontab -l
#1715698040
cat /etc/crontab
#1715698095
df -h /
#1715698185
systemctl list-timers --all --no-pager | head
#1715698437
cat /etc/hostname
#1715698518
htop
#1715699619
systemctl is-active sshd
#1715699803
journalctl -u sshd -n 50 --no-pager
#1715700142
ps aux | grep php-fpm
#1715701043
systemctl cat sshd 2>/dev/null | head -40
#1715701193
systemctl list-timers
#1715701528
df -h /tmp
#1715701556
cat /etc/fstab
#1715701564
date
#1715701618
df -h /var
#1715701962
ps -ef | head
#1715702029
nmcli connection show --active
#1715702055
tail -20 /var/log/auth.log
#1715702117
loginctl session-status
#1715706886
systemctl is-active php-fpm
#1715707030
journalctl -u nginx --since '30 min ago' --no-pager | tail -100
#1715707323
ps aux | grep sshd
#1715707418
systemctl show php-fpm -p ActiveState -p SubState -p MainPID
#1715707752
systemctl status NetworkManager --no-pager
#1715707785
env | sort | head
#1715707833
cat /proc/version | cut -d' ' -f1-3
#1715708398
systemctl restart sshd
#1715709450
ls -ltr /var/log | tail
#1715709508
ls -lt /var/log | head
#1715709538
resolvectl query company.okta.com
