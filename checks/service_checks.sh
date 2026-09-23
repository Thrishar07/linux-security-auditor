check_failed_services() {
    if ! command -v systemctl >/dev/null 2>&1; then
        check_result "Failed Services" "SERVICES" "MEDIUM" "WARN" "systemctl is not available"
        return
    fi

    failed=$(systemctl --failed --no-legend 2>/dev/null | grep -c .)

    if [ "$failed" -eq 0 ]; then
        check_result "Failed Services" "SERVICES" "MEDIUM" "PASS" "No failed system services detected"
    else
        check_result "Failed Services" "SERVICES" "MEDIUM" "WARN" "$failed failed system service(s) detected"
    fi
}


check_docker_service() {
    if ! command -v systemctl >/dev/null 2>&1; then
        check_result "Docker Service" "SERVICES" "LOW" "WARN" "systemctl is not available"
        return
    fi

    if systemctl is-active --quiet docker 2>/dev/null; then
        check_result "Docker Service" "SERVICES" "LOW" "PASS" "Docker service is running"
    else
        check_result "Docker Service" "SERVICES" "LOW" "WARN" "Docker service is not running"
    fi
}


check_unnecessary_services() {
    services=("telnet" "rsh" "rlogin" "ftp")

    found=0

    for service in "${services[@]}"; do
        if systemctl list-unit-files 2>/dev/null | grep -q "^$service.service"; then
            found=$((found + 1))
        fi
    done

    if [ "$found" -eq 0 ]; then
        check_result "Legacy Services" "SERVICES" "HIGH" "PASS" "No legacy insecure services detected"
    else
        check_result "Legacy Services" "SERVICES" "HIGH" "WARN" "$found legacy insecure service(s) installed"
    fi
}
