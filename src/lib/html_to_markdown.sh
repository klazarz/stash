# Helper: Convert Apple Notes title pattern to H1
# Apple Notes converts H1 to: <div><b><span style="font-size: 24px">Title</span></b></div>
_convert_apple_title_to_h1() {
	sed 's/<div><b><span style="font-size: 24px">\(.*\)<\/span><\/b><\/div>/<h1>\1<\/h1>/'
}

# Helper: Remove nbsp list separators
_remove_nbsp() {
	sed 's/^&nbsp;$//'
}

# Helper: Trim trailing whitespace
_trim_trailing_whitespace() {
	sed 's/[[:space:]]*$//'
}

html_to_markdown() {
	cat | _convert_apple_title_to_h1 | pandoc -f html -t gfm-raw_html --wrap=none | _remove_nbsp | _trim_trailing_whitespace | cat -s || {
		echo "Error: Failed to convert HTML to markdown" >&2
		return 1
	}
}
