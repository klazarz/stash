#!/usr/bin/env bash

source "$APPROVALS_BASH"
source "$LIB_PATH/read_markdown_file.sh"

describe "read_markdown_file"
  
  # Test 1: Read existing file
  approve "read_markdown_file \"$FIXTURES_PATH/simple.md\"" "read_markdown_file_existing"
  
  # Test 2: Read non-existing file (should fail gracefully)
  approve "read_markdown_file \"/nonexistent/path/file.md\" || echo \"Exit code: \$?\"" "read_markdown_file_non_existing"
  
  # Test 3: Read from stdin (no file path)
  approve "echo \"Content from stdin\" | read_markdown_file" "read_markdown_file_stdin"
  
  # Test 4: Read empty file
  approve "read_markdown_file \"$FIXTURES_PATH/empty.md\" || echo \"Exit code: \$?\"" "read_markdown_file_empty"
