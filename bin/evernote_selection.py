#!/usr/bin/env python
import os
import time
import codecs
from html2text import html2text
from fsevents import Observer, Stream

home = os.environ["HOME"]
now = lambda: time.mktime(time.localtime())
last = now()


def cb(*args):
    global last
    if now() - last > 1:
        codecs.open(os.path.join(home, "Documents/Evernote Selection.md"), "w", "utf-8") \
        .write(html2text(os.popen("""osascript -e \
        'tell application \"Evernote\"
            if selection is not {} then
                set the_selection to selection
                return HTML content of item 1 of the_selection
            else
                return \"\"
            end if
        end tell'""").read().decode("utf-8")))
        last = now()

cb()
observer = Observer()
observer.schedule(Stream(cb, os.path.join(home, "Library/Application Support/Evernote/data")))
observer.start()
