write_markdown_file() {
	local file_path="$1"
	local content="$2"
	
	if [ -z "$file_path" ]; then
		echo "Error: File path is required" >&2
		return 1
	fi
	
	# Check if file exists (we only update existing files)
	if [ ! -f "$file_path" ]; then
		echo "Error: File not found: $file_path" >&2
		return 1
	fi
	
	# Write content to file
	printf '%s\n' "$content" > "$file_path" || {
		echo "Error: Failed to write to file: $file_path" >&2
		return 1
	}
	
	return 0
}
