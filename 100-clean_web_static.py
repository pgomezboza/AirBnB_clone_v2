#!/usr/bin/python3
"""
Script that deletes out-of-date archives
using the function do_clean.
"""

from fabric.api import env, lcd, local, run
env.hosts = ['34.75.76.211', '3.90.215.119']


def do_clean(number=0):
    """This function removes old versions files"""
    n = int(number)
    if n < 0:
        return

    n = n + 1 if n > 0 else 2
    cmd = 'rm -rf $(ls -1t | tail -n+{})'.format(n)

    with lcd('versions'):
        local(cmd)

    with lcd('/data/web_static/releases'):
        run(cmd)
