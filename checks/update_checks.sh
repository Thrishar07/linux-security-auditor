check_pending_updates() {
    if ! command -v apt-get >/dev/null 2>&1; then
        check_result "Pending Updates" "UPDATES" "MEDIUM" "WARN" "APT package manager not found"
        return
    fi

    count=$(apt list --upgradable 2>/dev/null | tail -n +2 | grep -c .)

    if [ "$count" -gt 0 ]; then
        check_result "Pending Updates" "UPDATES" "MEDIUM" "WARN" "$count package(s) have available updates"
    else
        check_result "Pending Updates" "UPDATES" "MEDIUM" "PASS" "No pending updates found in the local package cache"
    fi
}


check_apt_service() {
    if command -v apt-get >/dev/null 2>&1; then
        check_result "Package Manager" "UPDATES" "LOW" "PASS" "APT package manager is available"
    else
        check_result "Package Manager" "UPDATES" "LOW" "WARN" "APT package manager is not available"
    fi
}
