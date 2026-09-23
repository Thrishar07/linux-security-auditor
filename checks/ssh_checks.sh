#!/bin/bash

check_root_login() {
    if grep -Eiq '^[[:space:]]*PermitRootLogin[[:space:]]+no([[:space:]]|$)' /etc/ssh/sshd_config 2>/dev/null; then
        check_result "SSH Root Login" "SSH" "HIGH" "PASS" "Root login is disabled"
    else
        check_result "SSH Root Login" "SSH" "HIGH" "WARN" "Could not confirm root login is disabled"
    fi
}

check_empty_passwords() {
    if awk -F: '($2 == "") { found=1 } END { exit !found }' /etc/shadow 2>/dev/null; then
        check_result "Empty Passwords" "USER" "HIGH" "FAIL" "Accounts with empty password fields found"
    else
        check_result "Empty Passwords" "USER" "HIGH" "PASS" "No empty password fields detected"
    fi
}

check_ssh_service() {
    if command -v sshd >/dev/null 2>&1; then
        check_result "SSH Service" "SSH" "MEDIUM" "PASS" "OpenSSH server binary is installed"
    else
        check_result "SSH Service" "SSH" "MEDIUM" "WARN" "OpenSSH server binary not found"
    fi
}
