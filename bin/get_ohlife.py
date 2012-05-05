#!/usr/bin/env python
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
import sys
import netrc
import errno

def die(msg, err):
    sys.stderr.write(msg)
    sys.exit(err)

try:
    import requests
except ImportError:
    die('please pip install requests', errno.ENOPKG)

login = netrc.netrc().authenticators('ohlife.com')
if not login:
    die('ohlife.com not found in netrc', errno.ENODATA)

try:
    cookies = requests.post('https://ohlife.com/latest',
        data={'email': login[0], 'pass': login[2]}
    ).cookies
    getreq = requests.get('https://ohlife.com/export/save', cookies=cookies)
    if getreq.status_code != requests.codes.ok:
        die('http error %s on getting, maybe wrong password?' %
                getreq.status_code, errno.EACCES)
    print getreq.text
except requests.exceptions.RequestException:
    die('connection error', errno.ECONNREFUSED)
