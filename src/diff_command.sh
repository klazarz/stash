# Read markdown file
file_path="${args[file]}"

if [ ! -f "$file_path" ]; then
	echo "Error: File not found: $file_path" >&2
	exit 2
fi

markdown_content=$(read_markdown_file "$file_path")

# Extract ID from frontmatter (required for diff)
note_id=$(get_id_from_frontmatter "$markdown_content")
if [ -z "$note_id" ]; then
	echo "Error: No apple_notes_id found in frontmatter" >&2
	exit 2
fi

# Find note in Apple Notes
if ! find_note "$note_id" > /dev/null; then
	echo "Error: Note not found in Apple Notes" >&2
	exit 2
fi

# Read note content from Apple Notes
html_content=$(read_note "$note_id")
if [ -z "$html_content" ]; then
	echo "Error: Failed to read note content" >&2
	exit 2
fi

# Convert remote HTML to markdown
remote_markdown=$(echo "$html_content" | html_to_markdown)

# Strip frontmatter from local content for fair comparison
local_markdown=$(echo "$markdown_content" | strip_frontmatter)

# Show diff: remote (old) vs local (new)
# diff returns 0 if same, 1 if different
diff -u --label "Apple Notes" --label "$file_path" \
	<(echo "$remote_markdown") <(echo "$local_markdown")
