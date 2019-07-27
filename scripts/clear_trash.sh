#!/bin/bash
# Clear Trash using "trash" tool (brew install trash)

ls -l /Users/davidg/.Trash
ls -l ~/.Trash
/usr/local/bin/trash -e -y
