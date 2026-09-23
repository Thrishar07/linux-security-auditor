check_firewall() {
    if command -v ufw >/dev/null 2>&1; then
        if ufw status | grep -q "Status: active"; then
            check_result "Firewall" "NETWORK" "HIGH" "PASS" "UFW firewall is active"
        else
            check_result "Firewall" "NETWORK" "HIGH" "FAIL" "UFW firewall is installed but inactive"
        fi

    elif command -v firewall-cmd >/dev/null 2>&1; then
        if firewall-cmd --state 2>/dev/null | grep -q "running"; then
            check_result "Firewall" "NETWORK" "HIGH" "PASS" "Firewalld is active"
        else
            check_result "Firewall" "NETWORK" "HIGH" "FAIL" "Firewalld is installed but inactive"
        fi

    else
        check_result "Firewall" "NETWORK" "HIGH" "WARN" "No supported firewall detected"
    fi
}


check_listening_ports() {
    ports=$(ss -lntup 2>/dev/null | tail -n +2 | wc -l)

    if [ "$ports" -eq 0 ]; then
        check_result "Listening Ports" "NETWORK" "MEDIUM" "PASS" "No listening network ports detected"
    else
        check_result "Listening Ports" "NETWORK" "MEDIUM" "WARN" "$ports listening network port(s) detected"
    fi
}


check_ip_forwarding() {
    forwarding=$(sysctl -n net.ipv4.ip_forward 2>/dev/null)

    if [ "$forwarding" = "0" ]; then
        check_result "IP Forwarding" "NETWORK" "MEDIUM" "PASS" "IPv4 IP forwarding is disabled"
    else
        check_result "IP Forwarding" "NETWORK" "MEDIUM" "WARN" "IPv4 IP forwarding is enabled"
    fi
}
