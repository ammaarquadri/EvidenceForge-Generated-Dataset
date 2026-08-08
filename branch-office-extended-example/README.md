# branch-office-extended-example

A 20-event Cisco Talos **EvidenceForge** scenario, built as an extended
version of the stock `scenarios/branch-office-example/scenario.yaml`. It
reuses the same small branch-office lab (AD domain, file server, DMZ web
portal, explicit forward proxy, firewall, IDS, Zeek span) but stretches the
attack storyline from 6 entries to 20, so a single `validate` + `generate`
run produces a fuller MITRE ATT&CK chain and touches every declared log
format at least once.

Place this folder inside your **Generated EvidenceForge dataset** repo as:

```
Generated-EvidenceForge-dataset/
└── branch-office-extended-example/
    ├── scenario.yaml
    └── README.md
```

---

## What is `scenario.yaml`?

It's a declarative config file that EvidenceForge reads to **simulate a
network and replay an attack through it**, producing realistic log data
(Windows events, Zeek, firewall, IDS, proxy, web-access, `bash_history`,
etc.) for training or testing SOC tooling — like the Agentic SOC pipeline.
Nothing in this file executes real code against a real network; it's a
specification the generator turns into synthetic log files.

Below is every top-level key in the file, what it means, and how it's used.

---

### `version` / `name` / `description`
Metadata only. `version` is the schema version EvidenceForge expects.
`name` is the scenario's unique identifier (used in tooling and in log
metadata) — kept as `branch-office-extended-example` so it never collides
with the original `branch-office-example`. `description` is a free-text
summary shown wherever scenarios are listed.

### `environment`
Defines the simulated network the attack plays out on.

- **`environment.description` / `environment.domain`** — one-line summary
  of the site, and the Active Directory domain name (`northstar-branch.local`).
- **`environment.timezone.default`** — the timezone used when rendering
  human-readable timestamps in generated logs.
- **`environment.proxy`** — declares an explicit forward proxy (as opposed
  to transparent), listening on port `8080`. This is what makes proxy
  (`squid`-style) logs possible for outbound traffic.
- **`environment.users`** — five named employees, each with a `persona`
  (accountant, sales, analyst, sysadmin, executive), a `primary_system`,
  AD `groups`, and a `browsing_intensity` that drives their baseline
  (non-attack) traffic volume. `nina.kapoor` is the sysadmin/domain-admin
  whose identity the attacker ends up using.
- **`environment.service_accounts`** — non-interactive accounts
  (`www-data`, `svc-backup`, `svc-proxy`) that generate service-style
  traffic instead of human browsing. `www-data` is the web server's
  service account and the attacker's initial foothold identity.
- **`environment.stale_accounts`** — dormant accounts kept only for
  realistic noise (old cached creds, retired scripts); not touched by the
  storyline.
- **`environment.systems`** — every host in the lab: five workstations, a
  domain controller, a file server, a Linux forward proxy, and a
  Linux/Nginx DMZ web server. Each entry has an `ip`, `os`, `type`,
  `services`, and (for servers) `roles` — this is what tells the generator
  which log formats a given host is even capable of producing.
- **`environment.network.segments`** — three VLANs (`workstations`,
  `servers`, `dmz`) with CIDRs, an `exposure` flag (`internal` vs `both`),
  and (for the DMZ) an `external_ratio` controlling how much of its traffic
  looks internet-originated.
- **`environment.network.sensors`** — the visibility layer that turns
  storyline events into log evidence: a Zeek SPAN covering all three
  segments, a perimeter IDS watching inbound DMZ traffic only, and a Cisco
  ASA firewall with NAT rules and an explicit allow/deny `policy` list.
  Without a sensor covering a segment, traffic there wouldn't produce logs.

### `time_window`
`start` is the simulation's real-world start timestamp. `duration` (`6h`)
is the total length of the run. `warmup` (`2h`) is a lead-in period of pure
baseline traffic before the attack begins — every storyline `time` (e.g.
`+20m`) is relative to **the end of warmup**, not to `start`.

### `baseline_activity`
Controls the "normal noise" layered under the attack: `intensity` and
`variation` of everyday browsing/file-share/auth traffic, and
`suspicious_noise` (how much unrelated-but-alert-worthy background activity
exists, to make the real attack harder to spot by volume alone).

### `observation_profile`
Set to `complete`, meaning every declared sensor and host emits logs for
everything it sees, rather than a sampled subset — useful for a training
dataset where you want full coverage.

### `logon_grace_period`
A `45m` window after a logon event during which subsequent process/file
activity on that host is still attributed to the same authenticated
session — this is what keeps a multi-step storyline entry (RDP in, then
`dir`, then `Compress-Archive` minutes later) tied together as one session
in the logs.

### `storyline` (the 20 attack events)
Each entry has an `id`, a relative `time`, the `actor` (which user/service
account identity the traffic uses), the `system` it runs on, a
human-readable `activity` summary, and one or more `events`. Each event
carries a `type` (`web_scan`, `ssh_session`, `process`, `port_scan`,
`rdp_session`, or `beacon` — all reused from the original scenario to stay
schema-safe) plus a MITRE ATT&CK `technique` and type-specific fields
(source/destination IPs, command lines, ports, etc.).

The 20-step chain:

| # | Phase | What happens |
|---|-------|--------------|
| 1–2 | Recon | External vuln scan (`nikto`) + directory brute force (`gobuster`) against the public portal |
| 3 | Initial access | Attacker gets an interactive shell on `WEB-BO-01` as `www-data` |
| 4–8 | Discovery / cred access | Identity, OS, network, and internal port-scan discovery; finds hard-coded creds in a config file |
| 9–12 | Lateral movement + collection | RDP to `FILE-BO-01` as `nina.kapoor`, share enumeration, archive staging, scheduled-task persistence |
| 13–15 | Domain compromise | RDP to `DC-BO-01`, Domain Admins/AD account enumeration |
| 16 | Further recon | Port scan of the workstation VLAN from the compromised admin workstation |
| 17 | C2 | Regular HTTPS beaconing through the explicit proxy |
| 18 | Defense evasion | Windows Security event log clearing |
| 19 | Exfiltration | Larger beacon session carrying the staged archive out |
| 20 | Close-out | Attacker's final SSH session on the web server ends |

### `red_herrings`
Benign-but-suspicious-looking activity that should **not** be flagged as
part of the attack: a mistyped VPN password (failed logons) and a
legitimate-but-heavy quarterly file export by an analyst. Same schema
shape as `storyline`, but scored separately so you can test an
analyst/detector's false-positive handling.

### `output`
`logs` lists every format to emit (`windows`, `zeek`, `ecar`, `syslog`,
`bash_history`, `snort_alert`, `cisco_asa`, `web_access`, `proxy_access`).
`destination` is the output folder; `compression` toggles whether the
result is zipped.

---

## How to run it

Run from your EvidenceForge project root (flag/command names may differ —
check `--help` if so):

```bash
# 1. Validate the scenario file against the schema
evidenceforge validate branch-office-extended-example/scenario.yaml

# 2. Generate the log dataset
evidenceforge generate branch-office-extended-example/scenario.yaml
```

Output lands wherever `output.destination` points — here that's
`scenarios/branch-office-extended-example/`.

---

## Next steps / ideas for improvement

- **Confirm the event-type/field schema against the real EvidenceForge
  docs or JSON schema.** This file only reuses types already proven valid
  in `branch-office-example`; if the tool supports more (`dns_query`,
  `smb_session`, `ldap_query`, `registry`, `file_transfer`, `email`, etc.)
  the storyline could get richer without inventing unsupported fields.
- **Run `evidenceforge validate` first** and fix any field-name or
  timestamp-format mismatches before generating — this draft has only been
  checked for valid YAML syntax, not against the live schema.
- **Add more red herrings** (e.g. an authorized internal vuln scan, a
  backup job that looks like mass file access) to stress-test
  false-positive handling further.
- **Vary `browsing_intensity` and `suspicious_noise`** to generate multiple
  dataset variants (quiet day vs. noisy day) from the same storyline.
- **Add a second, unrelated intrusion path** (e.g. a phishing-driven
  workstation compromise on `WS-OREED-01`) to test multi-incident
  correlation instead of a single linear kill chain.
- **Tighten timestamps** once real generation output is available, so
  session/process events land inside the correct `logon_grace_period`
  window relative to their parent logon.
- **Feed the generated logs into the Agentic SOC distillation/scoring
  pipeline** to confirm the 20-event chain surfaces as one coherent set of
  candidates rather than 20 disconnected alerts.

---

<a name="author"></a>
## 👨‍💻 Author

<div align="center">

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Orbitron&weight=700&size=32&pause=1000&color=00F0FF&center=true&vCenter=true&width=600&height=50&lines=Muhammad+Ammaar+Quadri)](https://git.io/typing-svg)

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=20&pause=1200&color=0EA5E9&center=true&vCenter=true&width=600&lines=CYBERRED+Applied+AI+Security+Intern)](https://git.io/typing-svg)

<br/>

[![GitHub](https://img.shields.io/badge/GitHub-ammaarquadri-181717?style=for-the-badge&logo=github&logoColor=00F0FF&labelColor=000000)](https://github.com/ammaarquadri)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-ammaarquadri-0A66C2?style=for-the-badge&logo=linkedin&logoColor=00F0FF&labelColor=000000)](https://linkedin.com/in/ammaarquadri)
[![Portfolio](https://img.shields.io/badge/Portfolio-Visit_Now-FF00FF?style=for-the-badge&logo=vercel&logoColor=00F0FF&labelColor=000000)](https://ammaar-quadri-123.vercel.app/)

</div>

---

## 📜 License

This repository is intended strictly for **educational, research, and internship demonstration purposes**.

---

⭐ **If you found this project useful, consider giving it a star!** ⭐

---

<p align="center">
  ⚡ Original design by <a href="https://github.com/ammaarquadri">@ammaarquadri</a>
</p>

<h2 align="center"> <b> Content © 2026 Ammaar Quadri. All rights reserved. </b></h2>
