#!/usr/bin/env python
# -*- coding: UTF-8 -*-

try:
    from AddressBook import ABAddressBook
    from itertools import chain

    ppl = {}
    for person in ABAddressBook.sharedAddressBook().people():
        prop = lambda v: person.valueForProperty_(v)
        emails = prop('Email')
        if emails:
            name = '%s %s' % tuple(map(lambda v: prop(v) or '', ['First', 'Last']))
            emails = [emails.valueAtIndex_(i) for i in range(0, emails.count())]
            ppl[name] = emails

    longest = len(max(list(chain.from_iterable(ppl.values())), key=len))

    for (name, emails) in ppl.iteritems():
        for e in emails:
            print e + ((longest - len(e)) * ' ') + ' \t' + name
except:
    # fail silently on non-Macs
    pass
