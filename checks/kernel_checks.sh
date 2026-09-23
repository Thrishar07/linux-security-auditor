check_aslr() {
    value=$(sysctl -n kernel.randomize_va_space 2>/dev/null)

    if [ "$value" = "2" ]; then
        check_result "ASLR" "KERNEL" "HIGH" "PASS" "Address Space Layout Randomization is fully enabled"
    elif [ "$value" = "1" ]; then
        check_result "ASLR" "KERNEL" "HIGH" "WARN" "ASLR is partially enabled"
    else
        check_result "ASLR" "KERNEL" "HIGH" "FAIL" "ASLR is disabled"
    fi
}


check_ip_forwarding() {
    value=$(sysctl -n net.ipv4.ip_forward 2>/dev/null)

    if [ "$value" = "0" ]; then
        check_result "IP Forwarding" "KERNEL" "MEDIUM" "PASS" "IPv4 packet forwarding is disabled"
    else
        check_result "IP Forwarding" "KERNEL" "MEDIUM" "WARN" "IPv4 packet forwarding is enabled"
    fi
}


check_core_dumps() {
    value=$(ulimit -c)

    if [ "$value" = "0" ]; then
        check_result "Core Dumps" "KERNEL" "MEDIUM" "PASS" "Core dumps are disabled for the current shell"
    else
        check_result "Core Dumps" "KERNEL" "MEDIUM" "WARN" "Core dumps are enabled"
    fi
}


check_suid_files() {
    count=$(find /usr /bin /sbin -type f -perm -4000 2>/dev/null | wc -l)

    if [ "$count" -eq 0 ]; then
        check_result "SUID Files" "KERNEL" "MEDIUM" "PASS" "No SUID files detected"
    else
        check_result "SUID Files" "KERNEL" "MEDIUM" "WARN" "$count SUID executable(s) detected"
    fi
}
