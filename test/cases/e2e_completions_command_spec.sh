#!/usr/bin/env bash

source "$APPROVALS_BASH"

describe "completions_command"

  approve "$CLI_PATH completions" "completions_command"
