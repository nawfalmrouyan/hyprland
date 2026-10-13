#!/usr/bin/env bash

# Check if screen is locked before performing action
if dms ipc call lock isLocked | grep -q "false"; then
  dms ipc lock lock
fi
