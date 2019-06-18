#!/usr/local/bin/python
# Shorten current path
# Based on:
# https://askubuntu.com/questions/17723/trim-the-terminal-command-prompt-working-directory/17738#17738
import os
pwd = os.getcwd()
homedir = os.path.expanduser('~')
pwd = pwd.replace(homedir, '~', 1)
if len(pwd) > 33:
    pwd = pwd[:10]+'...'+pwd[-20:] # first 10 chars+last 20 chars
print(pwd)
