extract_frontmatter() {
	cat | pcregrep -M -o '^---\s*([\s\S]*?)\s*^---'
}
