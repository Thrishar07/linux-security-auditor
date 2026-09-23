check_journald() {
    if command -v journalctl >/dev/null 2>&1; then
        if journalctl --no-pager -n 1 >/dev/null 2>&1; then
            check_result "System Logging" "LOGGING" "HIGH" "PASS" "systemd journal is available and readable"
        else
            check_result "System Logging" "LOGGING" "HIGH" "WARN" "systemd journal exists but could not be read"
        fi
    else
        check_result "System Logging" "LOGGING" "HIGH" "WARN" "journalctl is not available"
    fi
}


check_auth_log() {
    if [ -f /var/log/auth.log ]; then
        check_result "Authentication Log" "LOGGING" "HIGH" "PASS" "/var/log/auth.log exists"
    elif [ -f /var/log/secure ]; then
        check_result "Authentication Log" "LOGGING" "HIGH" "PASS" "/var/log/secure exists"
    else
        check_result "Authentication Log" "LOGGING" "HIGH" "WARN" "No standard authentication log found"
    fi
}


check_auditd() {
    if command -v auditd >/dev/null 2>&1 || command -v auditctl >/dev/null 2>&1; then
        check_result "Auditd" "LOGGING" "HIGH" "PASS" "Linux audit subsystem is installed"
    else
        check_result "Auditd" "LOGGING" "HIGH" "WARN" "Linux audit subsystem is not installed"
    fi
}
