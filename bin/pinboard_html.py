#!/usr/bin/env python
import sys
from xml.dom.minidom import parse
print '''<!DOCTYPE NETSCAPE-Bookmark-file-1>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Pinboard bookmarks</title>
<dl>'''
for item in parse(sys.argv[1]).getElementsByTagName('item'):
    print '<dt><a href="%s">%s</a></dt>' % \
    (item.getAttribute('rdf:about').encode('utf-8'),
     item.getElementsByTagName('title')[0].firstChild.data.encode('utf-8'))
print '</dl>'
