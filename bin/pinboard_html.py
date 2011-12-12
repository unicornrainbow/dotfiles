#!/usr/bin/env python
import sys
import urllib2
from xml.dom.minidom import parse
res = '''<!DOCTYPE NETSCAPE-Bookmark-file-1>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Pinboard bookmarks</title>
<dl>'''
feed = urllib2.urlopen("http://feeds.pinboard.in/rss/u:myfreeweb/").read()
for item in parse(feed).getElementsByTagName('item'):
    res += '<dt><a href="%s">%s</a></dt>\n' % \
    (item.getAttribute('rdf:about').encode('utf-8'),
     item.getElementsByTagName('title')[0].firstChild.data.encode('utf-8'))
res += '</dl>'
open('~/.bookmarks.html', 'w').write(res)
