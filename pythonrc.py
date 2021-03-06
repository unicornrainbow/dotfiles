# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://github.com/zacharyvoase/dotfiles/blob/master/pythonrc
# https://github.com/sontek/dotfiles/blob/master/_pythonrc.py
# http://brianlyttle.com/2011/10/python-interpreter-tab-completion-on-os-x/
# http://stackoverflow.com/questions/7116038/python-tab-completion-mac-osx-10-7-lion

import rlcompleter
import subprocess
import readline
import inspect
import atexit
import sys
import os
home = os.environ["HOME"]

try:
    from see import see
except ImportError:
    print >>sys.stderr, "Please pip install see"

def src(obj):
    def highlight(source):
        try:
            import pygments
            import pygments.formatters
            import pygments.lexers
        except ImportError:
            return source
        lexer = pygments.lexers.get_lexer_by_name('python')
        formatter = pygments.formatters.terminal.TerminalFormatter()
        return pygments.highlight(source, lexer, formatter)
    source = inspect.getsource(obj)
    pager = subprocess.Popen(['less', '-R'], stdin=subprocess.PIPE)
    pager.communicate(highlight(source))
    pager.wait()

try:
    class TabCompleter(rlcompleter.Completer):
        """Completer that supports indenting"""
        def complete(self, text, state):
            if not text:
                return ('    ', None)[state]
            else:
                return rlcompleter.Completer.complete(self, text, state)
    readline.set_completer(TabCompleter().complete)
    readline.set_history_length(1000)
    if 'libedit' in readline.__doc__:
        readline.parse_and_bind("bind '\t' rl_complete")
    else:
        readline.parse_and_bind(open("%s/.inputrc" % home).read())
    HISTFILE = "%s/.pyhistory." % home
    try:
        readline.read_history_file(HISTFILE)
    except: pass
    atexit.register(readline.write_history_file, HISTFILE)
except:
    print >>sys.stderr, "Couldn't get rlcompleter + readline working."

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

    M = DjangoModels()
    C = Client()
