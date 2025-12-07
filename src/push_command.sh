inspect_args

# Read markdown content from file path or stdin
if ! markdown_content=$(read_markdown_file "${args[file]}"); then
	echo "Error: Failed to read file ${args[file]}"
	exit 1
fi

# Extract ID from frontmatter
if ! note_id=$(get_id_from_frontmatter "$markdown_content"); then
	echo "Error: No ID found in markdown frontmatter" >&2
	exit 1
fi

echo "Extracted ID from frontmatter: $note_id"

# Find the note in Apple Notes using the extracted ID
if apple_note_id=$(find_note "$note_id"); then
	echo "Found note in Apple Notes: $apple_note_id"
else
	echo "Error: Note not found in Apple Notes" >&2
	exit 1
fi

