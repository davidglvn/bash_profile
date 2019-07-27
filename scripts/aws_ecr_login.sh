#!/bin/bash
# Used in script to avoid "File name too long" error

PATH="${PATH}:/usr/local/bin/"
/usr/local/bin/$(/usr/local/bin/aws ecr get-login --no-include-email)
