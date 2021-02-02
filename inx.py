#!/usr/bin/env python3

import sys
import os

wsl_host_ip = open(os.path.expanduser('~/.wslip'), 'r', encoding='utf-8').read().strip()

os.execvpe(sys.argv[1], sys.argv[1:], {**os.environ, 'DISPLAY': f'{wsl_host_ip}:0'})
