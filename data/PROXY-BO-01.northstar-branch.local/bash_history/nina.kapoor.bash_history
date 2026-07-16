#1715689769
whoami
#1715689784
ls /tmp
#1715689836
env | sort | head
#1715690005
cat /proc/meminfo | head -5
#1715690088
cd /tmp
#1715690181
journalctl -u NetworkManager --since '2 hours ago' --no-pager | tail -30
#1715690378
journalctl -u squid --since '30 min ago' --no-pager | tail -20
#1715690454
mount | column -t
#1715690523
cd /var/log
#1715690656
df -h /
#1715690781
cat /etc/os-release
#1715691529
tail -20 /var/log/syslog
#1715691538
ssh -l nina.kapoor WEB-BO-01.northstar-branch.local
#1715695813
ps aux | grep squid
#1715696013
loginctl user-status
#1715696084
top -bn1 | head -20
#1715696124
systemctl restart squid
#1715696421
ps -ef | head
#1715696428
find /etc/systemd/user -maxdepth 2 -type f 2>/dev/null | head
#1715696654
ip route
#1715697038
du -sh /tmp/*
#1715697118
ls -la
#1715697154
find /var/log -name '*.gz' -mtime +30 | wc -l
#1715697180
ss -tan | head
#1715697385
cat /etc/fstab
#1715697464
hostnamectl
#1715697556
cat /proc/meminfo | head -5
#1715697570
ls /tmp
#1715697659
groups
#1715697669
df -h /var
#1715697889
ip -br addr
#1715702260
uptime
#1715702326
free -h
#1715702610
whoami
#1715702676
ls -lh
#1715702753
history | tail -15
#1715702764
systemctl status NetworkManager --no-pager
#1715702929
systemctl list-units --failed
#1715703018
grep -i error /var/log/syslog | tail -50
#1715703027
find /var/log -name '*.gz' -mtime +30 | wc -l
#1715703096
nmcli device status 2>/dev/null
#1715703108
cat /proc/meminfo | head -5
#1715703139
ca
#1715703196
env | head -20
#1715703506
journalctl -p err --no-pager -n 10
#1715703053
ssh -tt nina.kapoor@WEB-BO-01.northstar-branch.local
#1715703581
systemctl is-active squid
#1715703611
journalctl -u squid --since '30 min ago' --no-pager | tail -20
#1715703689
ss -ltnp | grep squid
#1715703737
systemctl show squid -p ActiveState -p SubState -p MainPID
#1715704133
cat /proc/cpuinfo | grep 'model name' | head -1
#1715704142
sysctl -a 2>/dev/null | grep net.ipv4.ip_forward
#1715704294
netstat -an | grep ESTABLISHED | wc -l
#1715704370
date -u
#1715704482
crontab -l
#1715704524
id
#1715704944
systemctl status squid
#1715704974
systemctl status squid --no-pager
#1715705024
journalctl -u squid -n 200 --no-pager
#1715705069
systemctl cat squid 2>/dev/null | head -40
#1715705113
grep -i error /var/log/syslog | tail -50
#1715705179
ssh -o ConnectTimeout=10 nina.kapoor@WEB-BO-01.northstar-branch.local
#1715705753
ls /var/log
#1715705820
mount | column -t
