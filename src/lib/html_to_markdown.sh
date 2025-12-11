html_to_markdown() {
	cat | pandoc -f html -t gfm-raw_html --wrap=none | sed 's/^&nbsp;$//' | sed 's/[[:space:]]*$//' | cat -s || {
		echo "Error: Failed to convert HTML to markdown" >&2
		return 1
	}
}
