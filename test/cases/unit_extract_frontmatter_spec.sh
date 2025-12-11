#!/usr/bin/env bash

source "$APPROVALS_BASH"
source "$LIB_PATH/extract_frontmatter.sh"

describe "extract_frontmatter"
  
  approve "cat $FIXTURES_PATH/with_apple_id.md | extract_frontmatter" \
    "extract_frontmatter_with_apple_id"

  approve "cat $FIXTURES_PATH/with_frontmatter_no_id.md | extract_frontmatter" \
    "extract_frontmatter_with_frontmatter_no_id"

  approve "cat $FIXTURES_PATH/no_frontmatter.md | extract_frontmatter" \
    "extract_frontmatter_no_frontmatter"

  approve "cat $FIXTURES_PATH/empty.md | extract_frontmatter" \
    "extract_frontmatter_empty"
