#!/bin/sh
sensors | awk '/Package/ {sub(/^\+/, "", $4); sub(/\.0/, "", $4);print $4}'
