# Ground Truth: branch-office-example

**Scenario:** Beginner-friendly branch office scenario with a small mixed Windows/Linux
environment, explicit forward proxy, perimeter firewall, network sensors, and
a compact attack storyline. The attack begins with public web reconnaissance,
pivots through a compromised admin account, and ends with outbound beaconing
from a workstation so new users can see several log families in one run.


**Generated:** 2024-05-14 12:00:00 UTC


## Attack Summary

This scenario simulates the following attack sequence:

1. **www-data** on **WEB-BO-01**: External vulnerability scanner probes the public claims portal
2. **www-data** on **WEB-BO-01**: Attacker obtains a shell on the web server and checks process identity
3. **www-data** on **WEB-BO-01**: Attacker performs light internal discovery from the DMZ host
4. **nina.kapoor** on **FILE-BO-01**: Attacker uses compromised admin credentials to RDP from the DMZ web server to the file server
5. **nina.kapoor** on **FILE-BO-01**: Attacker enumerates file shares and stages a small archive
6. **nina.kapoor** on **WS-NKAPOOR-01**: Compromised admin workstation beacons through the explicit proxy to attacker infrastructure


## Timeline

| Timestamp | Actor | System | Event Type | Details |
|-----------|-------|--------|------------|---------|
| 2024-05-14 12:55:21 UTC | www-data | WEB-BO-01 | Web_Scan | Web scan (nikto) against 45.83.220.5:80 (61 requests) |
| 2024-05-14 13:04:37 UTC | www-data | WEB-BO-01 | Ssh_Session | SSH session to 10.44.30.10:22 (UID: CP0P9OiDMTd1FRHoW) |
| 2024-05-14 13:04:48 UTC | www-data | WEB-BO-01 | Process | Process: /usr/bin/id (PID: 744057) - `id` |
| 2024-05-14 13:10:02 UTC | www-data | WEB-BO-01 | Process | Process: /usr/sbin/ip (PID: 744171) - `ip addr` |
| 2024-05-14 13:10:15 UTC | www-data | WEB-BO-01 | Process | Process: /usr/sbin/ss (PID: 744212) - `ss -tulpn` |
| 2024-05-14 13:10:26 UTC | www-data | WEB-BO-01 | Port_Scan | Port scan: 8 targets, ports [22, 80, 445, 3389], 32 denied connections + ASA threat detection alert (733100) |
| 2024-05-14 13:23:50 UTC | nina.kapoor | FILE-BO-01 | Rdp_Session | RDP session to 10.44.20.20:3389 (UID: CGECAVlxHkIeWDbEzRD) |
| 2024-05-14 13:29:59 UTC | nina.kapoor | FILE-BO-01 | Process | Process: C:\Windows\System32\cmd.exe (PID: 5204) - `cmd.exe /c dir \\FILE-BO-01\Claims /s` |
| 2024-05-14 13:30:00 UTC | nina.kapoor | FILE-BO-01 | Process | Process: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe (PID: 5220) - `powershell.exe -NoProfile -Command Compress-Arc...` |
| 2024-05-14 13:44:02 UTC | nina.kapoor | WS-NKAPOOR-01 | Beacon | Beacon to 45.83.221.30:443 (8 attempts, 35m) |


## Source Evidence Status

Canonical ground truth remains authoritative. Source rows may be `visible`, `delayed`, `dropped`, `filtered`, or `out_of_window` depending on the selected observation profile and sensor placement.

| Storyline ID | Source | Status Counts |
|--------------|--------|---------------|
| evt-001 | asa | filtered: 1, visible: 60 |
| evt-001 | ecar | visible: 60 |
| evt-001 | ids | filtered: 1, visible: 13 |
| evt-001 | web | visible: 51 |
| evt-001 | zeek | filtered: 13, visible: 111 |
| evt-002 | asa | visible: 1 |
| evt-002 | ecar | visible: 7 |
| evt-002 | syslog | visible: 4 |
| evt-002 | zeek | visible: 1 |
| evt-003 | asa | visible: 32 |
| evt-003 | ecar | visible: 4 |
| evt-003 | zeek | visible: 32 |
| evt-004 | asa | visible: 1 |
| evt-004 | ecar | visible: 2 |
| evt-004 | sysmon | visible: 1 |
| evt-004 | windows_security | visible: 2 |
| evt-004 | zeek | visible: 1 |
| evt-005 | ecar | visible: 5 |
| evt-005 | sysmon | visible: 5 |
| evt-005 | windows_security | visible: 4 |
| evt-006 | asa | filtered: 8, visible: 14 |
| evt-006 | ecar | visible: 22 |
| evt-006 | proxy | visible: 8 |
| evt-006 | sysmon | visible: 8 |
| evt-006 | windows_security | visible: 16 |
| evt-006 | zeek | visible: 44 |
| red_herring:rh-001 | asa | visible: 2 |
| red_herring:rh-001 | ecar | visible: 3 |
| red_herring:rh-001 | windows_security | visible: 5 |
| red_herring:rh-001 | zeek | visible: 2 |


## Indicators of Compromise (IOCs)

### Network IOCs

- 10.44.20.20:3389 (Lateral Movement)
- 10.44.30.10:22 (Lateral Movement)
- 45.83.220.5:80 (Web Scan Target)
- 45.83.221.30:443 (Beacon Target)
- Port 22 (scan target)
- Port 3389 (scan target)
- Port 445 (scan target)
- Port 80 (scan target)
- Zeek UID: CGECAVlxHkIeWDbEzRD
- Zeek UID: CP0P9OiDMTd1FRHoW

### Process IOCs

- /usr/bin/id
- /usr/sbin/ip
- /usr/sbin/ss
- C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
- C:\Windows\System32\cmd.exe
- `cmd.exe /c dir \\FILE-BO-01\Claims /s`
- `id`
- `ip addr`
- `powershell.exe -NoProfile -Command Compress-Archive -Path \\FILE-BO-01\Claims\Q2 -DestinationPath C:\Windows\Temp\q2-rollup.zip -Force`
- `ss -tulpn`

### User IOCs

- nina.kapoor (compromised account)
- www-data (compromised account)


## Red Herrings

The following events appear suspicious but are benign. They are included to make the dataset more realistic.

| Timestamp | Actor | System | Activity | Why It's Benign |
|-----------|-------|--------|----------|-----------------|
| 2024-05-14 14:20:18 UTC | victor.hale | WS-VHALE-01 | Branch manager mistypes a password during a VPN reconnect | Benign user error that creates a small cluster of failed authentication evidence |
