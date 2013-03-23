#!/usr/bin/env python
import sys
from markdown import Markdown

print Markdown(extensions=[
    "meta", "extra", "codehilite", "headerid",
    "sane_lists", "smartypants"
]).convert(sys.stdin.read()).replace('codehilite', 'highlight')
