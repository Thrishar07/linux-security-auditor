#!/bin/bash

# ==========================================
# Linux Security Compliance Auditor
# ==========================================

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

check_result() {
    local name="$1"
    local category="$2"
    local severity="$3"
    local status="$4"
    local explanation="$5"

    echo "----------------------------------------"
    echo "Check       : $name"
    echo "Category    : $category"
    echo "Severity    : $severity"
    echo "Status      : $status"
    echo "Explanation : $explanation"

    case "$status" in
        PASS)
            ((PASS_COUNT++))
            ;;
        FAIL)
            ((FAIL_COUNT++))
            ;;
        WARN)
            ((WARN_COUNT++))
            ;;
    esac
}
source ./checks/ssh_check.sh
source ./checks/user_checks.sh
source ./checks/file_checks.sh
source ./checks/network_checks.sh
source ./checks/service_checks.sh
source ./checks/logging_checks.sh

check_root_login
check_empty_passwords
check_ssh_service

check_password_expiry
check_root_uid
check_sudo_access

check_passwd_permissions
check_shadow_permissions
check_group_permissions
check_gshadow_permissions

check_firewall
check_listening_ports
check_ip_forwarding

check_failed_services
check_docker_service
check_unnecessary_services

check_journald
check_auth_log
check_auditd
