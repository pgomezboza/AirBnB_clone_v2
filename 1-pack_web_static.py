#!/usr/bin/python3
"""
Script that distributes an archive
to your web serversusing the function do_deploy
"""

from fabric.api import local
from datetime import datetime as dt


def do_pack():
    """This function packs the contents of web_static into a tgz archive"""
    td = dt.utcnow()
    tgzname = 'versions/web_static_{}{}{}{}{}{}.tgz'\
        .format(td.year, td.month, td.day, td.hour, td.minute, td.second)

    if local('mkdir -p versions').failed:
        return None
    if local('tar -czvf {} web_static'.format(tgzname)).failed:
        return None
    return tgzname
