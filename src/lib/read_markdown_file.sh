read_markdown_file() {
	local file_path="$1"

	if [ -n "$file_path" ]; then
		if [ ! -f "$file_path" ]; then
			echo "Error: File not found: $file_path" >&2
			return 1
		fi
		cat "$file_path"
	else
		cat
	fi

	return 0
}
