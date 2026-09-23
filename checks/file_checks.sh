check_passwd_permissions() {
    perms=$(stat -c "%a" /etc/passwd 2>/dev/null)

    if [ "$perms" -le 644 ]; then
        check_result "passwd Permissions" "FILES" "MEDIUM" "PASS" "/etc/passwd permissions are $perms"
    else
        check_result "passwd Permissions" "FILES" "MEDIUM" "FAIL" "/etc/passwd permissions are too permissive: $perms"
    fi
}

check_shadow_permissions() {
    perms=$(stat -c "%a" /etc/shadow 2>/dev/null)

    if [ "$perms" -le 640 ]; then
        check_result "shadow Permissions" "FILES" "HIGH" "PASS" "/etc/shadow permissions are $perms"
    else
        check_result "shadow Permissions" "FILES" "HIGH" "FAIL" "/etc/shadow permissions are too permissive: $perms"
    fi
}

check_group_permissions() {
    perms=$(stat -c "%a" /etc/group 2>/dev/null)

    if [ "$perms" -le 644 ]; then
        check_result "group Permissions" "FILES" "MEDIUM" "PASS" "/etc/group permissions are $perms"
    else
        check_result "group Permissions" "FILES" "MEDIUM" "FAIL" "/etc/group permissions are too permissive: $perms"
    fi
}

check_gshadow_permissions() {
    perms=$(stat -c "%a" /etc/gshadow 2>/dev/null)

    if [ "$perms" -le 640 ]; then
        check_result "gshadow Permissions" "FILES" "HIGH" "PASS" "/etc/gshadow permissions are $perms"
    else
        check_result "gshadow Permissions" "FILES" "HIGH" "FAIL" "/etc/gshadow permissions are too permissive: $perms"
    fi
}
