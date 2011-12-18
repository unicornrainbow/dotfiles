# thanks:
# Zachary Voase: https://github.com/zacharyvoase/dotfiles/blob/master/pythonrc
# John Anderson: https://github.com/sontek/dotfiles/blob/master/_pythonrc.py

import inspect
import sys
import os

try:
    import rlcompleter
    import readline
    home = os.environ["HOME"]
    readline.parse_and_bind(open("%s/.inputrc" % home).read())
    if not "bpython" in os.environ["_"]:
        HISTFILE = "%s/.pyhistory." % home

        if os.path.exists(HISTFILE):
            readline.read_history_file(HISTFILE)
        readline.set_history_length(300)
        def savehist():
            readline.write_history_file(HISTFILE)
        import atexit
        atexit.register(savehist)
except:
    print >>sys.stderr, "Couldn't get rlcompleter + readline working."

try:
    from see import see
except ImportError:
    print >>sys.stderr, "Please pip install see"

if "DJANGO_SETTINGS_MODULE" in os.environ:
    from django.db.models.loading import get_models
    from django.test.client import Client
    from django.test.utils import setup_test_environment, teardown_test_environment
    from django.conf import settings as S

    class DjangoModels(object):
        """Loop through all the models in INSTALLED_APPS and import them."""
        def __init__(self):
            for m in get_models():
                setattr(self, m.__name__, m)

    A = DjangoModels()
    C = Client()
