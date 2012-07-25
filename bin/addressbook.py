#!/usr/bin/env python
# -*- coding: UTF-8 -*-
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

try:
    from AddressBook import ABAddressBook
    from itertools import chain
    import sys

    ppl = {}
    for person in ABAddressBook.sharedAddressBook().people():
        prop = lambda v: person.valueForProperty_(v)
        emails = prop('Email')
        if emails:
            name = '%s %s' % tuple(map(lambda v: prop(v) or '', ['First', 'Last']))
            emails = [emails.valueAtIndex_(i) for i in range(0, emails.count())]
            ppl[name] = emails

    if len(sys.argv) >= 2:
        print 'searching' # mutt requires one extra line
        query = sys.argv[-1].lower()
        for (name, emails) in ppl.iteritems():
            if name.lower().startswith(query):
                for e in emails:
                    print e + '\t' + name
            else:
                for e in emails:
                    if e.startswith(query):
                        print e + '\t' + name
    else:
        longest = len(max(list(chain.from_iterable(ppl.values())), key=len))

        for (name, emails) in ppl.iteritems():
            for e in emails:
                print e + ((longest - len(e)) * ' ') + ' \t' + name
except:
    # fail silently on non-Macs
    pass
