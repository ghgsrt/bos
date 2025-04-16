should_sudo() {
	if [ "$USER" = "root" ]; then
        $@
		return
    fi

	# Check if user is in wheel group
    if groups "$USER" | grep -q "\bwheel\b"; then
        sudo "$@"
    fi
}