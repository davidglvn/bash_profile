#!/bin/bash
# Clear all files from specific path that don't have "keep" tag
# Files moved to Trash using "trash" tool (brew install trash)

CLEAR_PATH=$1

mdfind '!kMDItemUserTags=keep' -onlyin ${CLEAR_PATH} -0 | while IFS= read -r -d '' file; do
    /usr/local/bin/trash -F "${file}"
done
