#!/usr/bin/env bash
clear
echo "Creating zero byte dummy files instead of movies..."
for s in *.bk2; do
  : > "$s"
done
