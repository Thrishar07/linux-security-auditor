# 🔐 Linux Security Compliance Auditor

A Bash-based security auditing tool that automatically scans a Linux system for common security misconfigurations and generates a compliance report.

The auditor checks system configuration across multiple security domains and classifies each finding as **PASS**, **WARN**, or **FAIL**. It also calculates an overall compliance score and generates an HTML report for easier analysis.

---

## 🚀 Features

* 🔍 Automated Linux security checks
* 🛡️ SSH configuration auditing
* 👤 User and password security checks
* 📁 Sensitive file permission checks
* 🌐 Firewall and network security checks
* ⚙️ Service security checks
* 📝 Logging and auditing checks
* 🔒 Kernel hardening checks
* 📦 Package update checks
* 📊 PASS / WARN / FAIL classification
* 📈 Compliance score calculation
* 🌐 HTML security report generation
* 🧩 Modular Bash architecture
* 🐧 Designed for Linux environments

---

## 🏗️ Project Architecture

```text
linux-security/
│
├── auditor.sh
│
├── checks/
│   ├── ssh_checks.sh
│   ├── user_checks.sh
│   ├── file_checks.sh
│   ├── network_checks.sh
│   ├── service_checks.sh
│   ├── logging_checks.sh
│   ├── kernel_checks.sh
│   └── update_checks.sh
│
├── reports/
│   └── report.html
│
├── tests/
│
└── README.md
```

---

## 🔄 How It Works

```text
                ┌─────────────────────┐
                │     auditor.sh      │
                │    Main Engine      │
                └──────────┬──────────┘
                           │
             ┌─────────────┴─────────────┐
             │     Load Check Modules    │
             └─────────────┬─────────────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
      SSH              Users             Files
        │                  │                  │
        └──────────────────┼──────────────────┘
                           │
                           ▼
                    Network / Services
                           │
                           ▼
                  Logging / Kernel
                           │
                           ▼
                      Updates
                           │
                           ▼
                  PASS / WARN / FAIL
                           │
              ┌────────────┴────────────┐
              ▼                         ▼
        Terminal Output            HTML Report
              │                         │
              └────────────┬────────────┘
                           ▼
                  Compliance Score
```

---

## 🔍 Security Checks

### 1. SSH Security

The auditor checks:

* SSH root login configuration
* Empty password fields
* OpenSSH server availability

Example:

```text
SSH Root Login → WARN
SSH Service    → PASS
```

---

### 2. User & Password Security

Checks include:

* Password expiry
* Additional UID 0 accounts
* Sudo group membership

For example, the auditor checks `/etc/passwd` for accounts other than `root` with UID `0`.

```bash
awk -F: '$3 == 0 && $1 != "root"'
```

UID `0` represents root-level privileges, so unexpected UID 0 accounts are reported as a high-severity finding.

---

### 3. File Permissions

Sensitive system files are checked for overly permissive permissions:

```text
/etc/passwd
/etc/shadow
/etc/group
/etc/gshadow
```

The auditor uses Linux `stat` to inspect file permissions.

```bash
stat -c "%a" /etc/shadow
```

---

### 4. Network Security

The network module checks:

* Firewall status
* Listening network ports
* IPv4 forwarding

Example:

```bash
ss -lntup
```

This identifies services listening for network connections.

Listening ports are reported as findings rather than automatically being treated as vulnerabilities because legitimate applications may require network access.

---

### 5. Service Security

Checks include:

* Failed system services
* Docker service status
* Legacy/insecure services

The auditor uses Linux service-management tools such as:

```bash
systemctl
```

---

### 6. Logging & Auditing

The logging module checks:

* systemd journal availability
* Authentication logs
* Linux audit subsystem

Tools used include:

```bash
journalctl
auditctl
```

---

### 7. Kernel Hardening

Checks include:

* ASLR configuration
* Core dumps
* SUID executables

For example:

```bash
sysctl -n kernel.randomize_va_space
```

ASLR value `2` indicates full address-space randomization.

---

### 8. Updates & Patching

The auditor checks whether packages have available updates using APT.

```bash
apt list --upgradable
```

This helps identify systems that may require package maintenance.

---

# 📊 Compliance Scoring

The project uses a simple scoring model:

| Status | Points |
| ------ | ------ |
| PASS   | 100    |
| WARN   | 50     |
| FAIL   | 0      |

The overall score is calculated as:

```text
(PASS × 100 + WARN × 50 + FAIL × 0) / Total Checks
```

Example:

```text
Total Checks : 20
PASS         : 16
WARN         : 3
FAIL         : 1

Score        : 87 / 100
```

> **Note:** This is a project-defined scoring metric and is not an official compliance certification or industry-standard security score.

---

# 🖥️ Example Terminal Output

```text
========================================
    LINUX SECURITY COMPLIANCE AUDITOR
========================================

========== SSH SECURITY CHECKS ==========

----------------------------------------
Check       : SSH Root Login
Category    : SSH
Severity    : HIGH
Status      : WARN
Explanation : Could not confirm root login is disabled
----------------------------------------

----------------------------------------
Check       : Empty Passwords
Category    : USER
Severity    : HIGH
Status      : PASS
Explanation : No empty password fields detected
----------------------------------------

----------------------------------------
Check       : SSH Service
Category    : SSH
Severity    : MEDIUM
Status      : PASS
Explanation : OpenSSH server binary is installed
----------------------------------------

========================================
          COMPLIANCE SUMMARY
========================================
Total Checks : 25
PASS         : 19
FAIL         : 1
WARN         : 5
Score        : 86 / 100
========================================

Audit completed.
```

*Example output only; actual results depend on the system being audited.*

---

# 🌐 HTML Report

The auditor generates:

```text
reports/report.html
```

The report contains:

* Security check name
* Category
* Severity
* Status
* Explanation
* Compliance summary
* Overall score

Open the report from Windows/WSL using your file browser or browser.

---

# 🛠️ Technologies Used

* **Bash Shell Scripting**
* **Linux**
* **Ubuntu**
* `awk`
* `grep`
* `sed`
* `find`
* `stat`
* `ss`
* `systemctl`
* `journalctl`
* `sysctl`
* `apt`
* HTML/CSS

---

# ⚙️ Installation

Clone the repository:

```bash
git clone <your-repository-url>
```

Enter the project directory:

```bash
cd linux-security
```

Make the auditor executable:

```bash
chmod +x auditor.sh
```

---

# ▶️ Usage

Run the auditor:

```bash
./auditor.sh
```

or:

```bash
bash auditor.sh
```

The auditor performs the configured checks and generates:

```text
reports/report.html
```

---

# 🧪 Testing

The project can be tested in an isolated Linux environment such as:

* Ubuntu VM
* Docker container
* WSL Ubuntu

Before testing, inspect the system configuration:

```bash
cat /etc/passwd
cat /etc/shadow
ss -lntup
systemctl --failed
sysctl kernel.randomize_va_space
```

Tests should include both secure and intentionally misconfigured environments to verify that the auditor correctly identifies security findings.

---

# 🔐 Safety

The current auditing functionality is primarily **read-only**.

The auditor:

* Reads system configuration
* Inspects permissions
* Checks services
* Checks network configuration
* Reports findings

It does not automatically modify system configuration during normal auditing.

Future remediation functionality should use explicit user confirmation, backups, and a `--dry-run` mode before making changes.

---

# 📈 Future Improvements

Planned improvements include:

* [ ] `--dry-run` mode
* [ ] Safe `--fix` remediation
* [ ] Automatic configuration backups
* [ ] JSON report generation
* [ ] Configurable security policies
* [ ] More precise SSH effective-configuration checks
* [ ] Security-update-specific detection
* [ ] Automated test suite
* [ ] CI/CD integration
* [ ] Docker-based testing environment
* [ ] Improved HTML dashboard
* [ ] Historical audit comparison

---

# 💡 Key Learning Outcomes

Through this project, I worked with:

* Bash functions and modular scripting
* Linux configuration files
* File permissions and ownership
* Linux networking utilities
* System services
* System logging
* Kernel security parameters
* Package management
* Shell command pipelines
* Process exit codes
* Automated reporting
* Basic security compliance concepts

---

# 👩‍💻 Author

**Thrisha R**

Third-year Electronics & Communication Engineering student focused on **DevOps, Linux, Cloud, and Software Engineering**.

---

## 📌 Project Summary

**Linux Security Compliance Auditor** is a modular Bash security auditing tool that evaluates common Linux security configurations, reports PASS/WARN/FAIL findings, calculates a project-defined compliance score, and generates an HTML security report.

It demonstrates practical experience with **Linux administration, Bash scripting, networking, system services, security auditing, and automation**.

