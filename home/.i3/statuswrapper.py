#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import sys
import json
import subprocess
import os
import re

GREEN      = '#859900'
LIGHT_BLUE = '#268bd2'
RED        = '#dc322f'
ORANGE     = '#cb4b16'
YELLOW     = '#b58900'

regex_time = re.compile("([0-9]+):([0-9]+):([0-9]+)")
regex_battery = re.compile("([0-9]+)h")
regex_wifi = re.compile("off")

clocks = [ "🕛", "🕧", "🕐", "🕜", "🕑", "🕝", "🕒", "🕞", "🕓", "🕟", "🕔", "🕠", "🕕", "🕖", "🕗", "🕘", "🕙", "🕚", "🕡", "🕢", "🕣", "🕤", "🕥", "🕦", ]

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line = read_line()
        full_line = ''
        while line != 'end':
            full_line += line
            line, prefix = read_line(), ''

        j = json.loads(full_line)

        for e in j:
            if 'name' in e:
                name = e['name']
            else:
                continue

            text = e['full_text']
            if name == "volume":
                code = str(subprocess.check_output("audio"))
                if code[2] == '1':
                    e['full_text'] = "%s🎧" % text
                    e['color'] = YELLOW
            elif name == "wireless":
                if regex_wifi.search(text):
                    e['color'] = RED
                else:
                    e['color'] = GREEN
            elif name == 'time':
                match_hrs = regex_time.search(text)
                if match_hrs:
                    h = match_hrs.group(1)
                    h = int(h) % 12
                    m = match_hrs.group(2)
                    m = 1 if int(m) > 30 else 0
                    clock = clocks[h*2 + m]
                    e['full_text'] = "%s%s" % (clock, text)
                sys.stderr.write(str(match_hrs.group(1)))
            elif name == 'battery':
                if text.startswith('charging'):
                    e['full_text'] = "🔌%s" % (text)
                    e['color'] = ORANGE
                else: # 🗲
                    e['full_text'] = "🔋%s" % (text)
                    match_hrs = regex_battery.search(text)
                    if match_hrs and match_hrs.group(1) == '0':
                        e['color'] = RED
                    else:
                        e['color'] = LIGHT_BLUE

        print_line(json.dumps(j) + ',')
