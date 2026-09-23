check_password_expiry() {
    if awk -F: '($2 != "" && $3 > 0 && $5 > 90) { found=1 } END { exit !found }' /etc/shadow 2>/dev/null; then
        check_result "Password Expiry" "USER" "MEDIUM" "WARN" "Some accounts have password expiry greater than 90 days"
    else
        check_result "Password Expiry" "USER" "MEDIUM" "PASS" "No accounts with password expiry greater than 90 days detected"
    fi
}

check_root_uid() {
    if awk -F: '$3 == 0 && $1 != "root" { found=1 } END { exit !found }' /etc/passwd; then
        check_result "UID 0 Accounts" "USER" "HIGH" "FAIL" "Additional accounts with UID 0 found"
    else
        check_result "UID 0 Accounts" "USER" "HIGH" "PASS" "Only root has UID 0"
    fi
}

check_sudo_access() {
    if getent group sudo >/dev/null 2>&1; then
        count=$(getent group sudo | awk -F: '{print $4}' | tr ',' '\n' | grep -c .)

        if [ "$count" -gt 0 ]; then
            check_result "Sudo Access" "USER" "MEDIUM" "WARN" "$count user(s) have sudo group membership"
        else
            check_result "Sudo Access" "USER" "MEDIUM" "PASS" "No users found in sudo group"
        fi
    else
        check_result "Sudo Access" "USER" "MEDIUM" "PASS" "Sudo group not found"
    fi
}
