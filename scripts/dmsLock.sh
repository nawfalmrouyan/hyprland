#!/usr/bin/env bash

STATUS=$(dms ipc lock isLocked)

if [ "$STATUS" == "false" ]; then
  $(dms ipc lock lock)
  exit 0
else
  exit 1
fi
