#!/usr/bin/env bash

source "$APPROVALS_BASH"

# Source all lib functions
for f in "$LIB_PATH"/*.sh; do source "$f"; done

SRC_PATH="$PWD/../src"

describe "diff_command"

  # Regex to normalize temp file paths in output
  TEMP_FILE_REGEX="\/var\/folders\/[^[:space:]]+"

  # Test 1: Files with differences -> shows unified diff
  context "with changes"
    test_file=$(mktemp)
    cat > "$test_file" << 'EOF'
---
apple_notes_id: x-coredata://test/ICNote/p123
---

# Local Title

Local content that differs from remote.
EOF

    allow_diff "$TEMP_FILE_REGEX"
    approve "
      find_note() { echo 'x-coredata://test/ICNote/p123'; return 0; }
      read_note() { echo '<h1>Remote Title</h1><p>Remote content from Apple Notes.</p>'; return 0; }
      export -f find_note read_note
      declare -A args; args[file]='$test_file'
      source \$SRC_PATH/diff_command.sh
      unset -f find_note read_note
    " "diff_with_changes"

    rm -f "$test_file"

  # Test 2: Files are identical -> no output, exit 0
  context "no changes"
    test_file=$(mktemp)
    cat > "$test_file" << 'EOF'
---
apple_notes_id: x-coredata://test/ICNote/p123
---

# Same Title

Same content.
EOF

    allow_diff "$TEMP_FILE_REGEX"
    approve "
      find_note() { echo 'x-coredata://test/ICNote/p123'; return 0; }
      read_note() { echo '<h1>Same Title</h1><p>Same content.</p>'; return 0; }
      export -f find_note read_note
      declare -A args; args[file]='$test_file'
      source \$SRC_PATH/diff_command.sh
      unset -f find_note read_note
    " "diff_no_changes"

    rm -f "$test_file"

  # Test 3: File without apple_notes_id -> error
  context "no frontmatter"
    test_file=$(mktemp)
    echo "# No Frontmatter" > "$test_file"

    allow_diff "$TEMP_FILE_REGEX"
    approve "
      declare -A args; args[file]='$test_file'
      source \$SRC_PATH/diff_command.sh 2>&1 || true
    " "diff_no_frontmatter"

    rm -f "$test_file"

  # Test 4: Note not found in Apple Notes -> error
  context "note not found"
    test_file=$(mktemp)
    cat > "$test_file" << 'EOF'
---
apple_notes_id: x-coredata://orphaned/ICNote/p999
---
# Orphaned Note
EOF

    allow_diff "$TEMP_FILE_REGEX"
    approve "
      find_note() { return 1; }
      export -f find_note
      declare -A args; args[file]='$test_file'
      source \$SRC_PATH/diff_command.sh 2>&1 || true
      unset -f find_note
    " "diff_note_not_found"

    rm -f "$test_file"

  # Test 5: Non-existent file -> error
  context "non-existent file"
    approve "
      declare -A args; args[file]='/nonexistent/path/to/file.md'
      source \$SRC_PATH/diff_command.sh 2>&1 || true
    " "diff_nonexistent_file"
