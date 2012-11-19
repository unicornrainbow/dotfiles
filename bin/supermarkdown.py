#!/usr/bin/env python
import sys
from markdown import Markdown

print Markdown(extensions=[
    "meta", "extra", "codehilite", "headerid(level=2)",
    "sane_lists", "smartypants"
]).convert(sys.stdin.read())
