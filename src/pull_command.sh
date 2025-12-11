# Read markdown file
file_path="${args[file]}"

if [ ! -f "$file_path" ]; then
	echo "Error: File not found: $file_path" >&2
	exit 1
fi

echo "Reading file: $file_path"
markdown_content=$(read_markdown_file "$file_path")

# Extract ID from frontmatter (required for pull)
note_id=$(get_id_from_frontmatter "$markdown_content")
if [ -z "$note_id" ]; then
	echo "Error: No apple_notes_id found in frontmatter" >&2
	exit 1
fi

# Find note in Apple Notes
echo "Searching for note..."
if ! find_note "$note_id" > /dev/null; then
	echo "Error: Note not found in Apple Notes" >&2
	exit 1
fi

# Read note content
echo "Reading note content..."
html_content=$(read_note "$note_id")
if [ -z "$html_content" ]; then
	echo "Error: Failed to read note content" >&2
	exit 1
fi

# Convert HTML to Markdown
markdown_body=$(echo "$html_content" | html_to_markdown)

# Extract existing frontmatter and rebuild file content
frontmatter=$(echo "$markdown_content" | extract_frontmatter)

# Combine: frontmatter + empty line + markdown body
updated_content=$(printf '%s\n\n%s' "$frontmatter" "$markdown_body")

# Write back to file
write_markdown_file "$file_path" "$updated_content"

echo "File updated: $file_path"
