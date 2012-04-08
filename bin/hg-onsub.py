# onsub.py - execute commands recursively on subrepositories
#
# Copyright 2010, 2011 aragost Trifork
#
# This software may be used and distributed according to the terms of
# the GNU General Public License version 2 or any later version.

import os
from mercurial.i18n import _
from mercurial import extensions, subrepo, util

"""execute a command in each subrepository"""

def onsub(ui, repo, *args, **opts):
    """execute a command in each subrepository

    Executes CMD with the current working directory set to the root of
    each subrepository. By default, execution stops if CMD returns a
    non-zero exit code. Use --ignore-errors to override this.

    If a POST-CMD is specified, this will be executed after all
    subrepositories below the current subrepository has been visited.
    This corresponds to a post-order traversal of the tree.

    It is an error to specify a POST-CMD together with the
    --breadth-first flag.

    Use --verbose/-v to print the command being run and the subrepo
    name for each run of CMD in a subrepo. Alternately, use
    --print0/-0 to print just the subrepo name followed by a NUL
    character instead of a newline. This can be useful in combination
    with :hg:`status --print0`.

    The command has access to the following environment variables:

    ``HG_REPO``:
        Absolute path to the top-level repository in which the onsub
        command was executed.

    ``HG_SUBPATH``:
        Relative path to the current subrepository from the top-level
        repository.

    ``HG_SUBURL``:
        URL for the current subrepository as specified in the
        containing repository's ``.hgsub`` file.

    ``HG_SUBSTATE``:
        State of the current subrepository as specified in the
        containing repository's ``.hgsubstate`` file.
    """

    # function level "constants" - these won't be modified by the nested functions
    print0 = opts.get('print0')
    if opts.get('ignore_errors'):
        onerr = None
    else:
        onerr = util.Abort
    maxdepth = opts.get('max_depth')
    precmd = None
    postcmd = None
    includeroot = opts.get('root_repo')

    def execCmd(sub, cmd):
        """if sub == None, cmd is executed inside repo; else, inside sub.
        If cmd == None, do nothing. If cmd == '', do only the print0 (if needed). 
        Else, do either print0 or the debugging message, then execute the command.
        """
        if sub == None:
            envargdict = dict(HG_SUBPATH='.',
                              HG_SUBURL='.',
                              HG_SUBSTATE=repo['.'].hex(),
                              HG_REPO=repo.root)
            relpath = '.'
            cmdwd = repo.root
        else:
            # subrepo.relpath was renamed to subrepo.subrelpath in
            # 18b5b6392fcf.
            if hasattr(subrepo, 'relpath'):
                relpath = subrepo.relpath(sub)
            else:
                relpath = subrepo.subrelpath(sub)
            envargdict = dict(HG_SUBPATH=relpath,
                              HG_SUBURL=sub._path,
                              HG_SUBSTATE=sub._state[1],
                              HG_REPO=repo.root)
            cmdwd = os.path.join(repo.root, relpath)
        if cmd != None:
            if print0:
                ui.write(relpath, "\0")
            if cmd != '':
                if not print0: ui.note(_("executing '%s' in %s\n") % (cmd, relpath))
                util.system(cmd, environ=envargdict, cwd=cmdwd, onerr=onerr,
                            errprefix=_('terminated onsub in %s') % relpath)

    def bfs():
        """execute precmd in repo.root and in each subrepository, breadth-first"""
        if includeroot:
            execCmd(None, precmd) 
        ctx = repo['.']
        work = [(1, ctx.sub(subpath)) for subpath in sorted(ctx.substate)]
        while work:
            (depth, sub) = work.pop(0)
            if depth > maxdepth >= 0:
                continue
            execCmd(sub, precmd) 
            if isinstance(sub, subrepo.hgsubrepo):
                rev = sub._state[1]
                ctx = sub._repo[rev]
                w = [(depth + 1, ctx.sub(subpath)) 
                     for subpath in sorted(ctx.substate)]
                work.extend(w)
    
    def dfs():
        """execute pre-/postcmd in repo.root and in each subrepository, depth-first"""

        def dfs_rek(depth, sub):
            if depth > maxdepth >= 0:
                return
            execCmd(sub, precmd) 
            if isinstance(sub, subrepo.hgsubrepo):
                rev = sub._state[1]
                ctx = sub._repo[rev]
                for subpath in sorted(ctx.substate):
                    dfs_rek(depth+1, ctx.sub(subpath))
            execCmd(sub, postcmd)
    
        ctx = repo['.']
        work = [ctx.sub(subpath) for subpath in sorted(ctx.substate)]
        if includeroot:
            execCmd(None, precmd) 
        for sub in work:
            dfs_rek(1, sub)
        if includeroot:
            execCmd(None, postcmd) 
        
    ### start of main function part ###
    if len(args) == 2:
        precmd = args[0]
        postcmd = args[1]
        if opts.get('breadth_first') or opts.get('post_order'):
            raise util.Abort(_("onsub: '-b' and '-p' imply the use of only one command"))
    elif len(args) == 1:
        if opts.get('post_order'):
            precmd = None
            postcmd = args[0]
        else:
            precmd = args[0]
            postcmd = None
    elif len(args) == 0:
        # cmd == '' means only do print0
        if opts.get('post_order'):
            precmd = None
            postcmd = ''
        else:
            precmd = ''
            postcmd = None
    else:
        raise util.Abort(_("onsub: at most 2 command arguments required"))
    if opts.get('post_order') and opts.get('breadth_first'):
        raise util.Abort(_("onsub: '-b' and '-p' are mutually exclusive"))

    if opts.get('breadth_first'):
        bfs()
    else:
        dfs()
          
cmdtable = {
    "onsub":
        (onsub,
         [('b', 'breadth-first', None,
           _('use breadth-first traversal')),
          ('p', 'post-order', None,
           _('use post-order depth-first traversal')),
          ('', 'root-repo', None,
           _('include root repository in traversal')),
          ('', 'max-depth', -1,
           _('limit recursion to N levels (negative for no limit)'), 'N'),
          ('', 'ignore-errors', None,
           _('continue execution despite errors')),
          ('0', 'print0', None,
           _('end subrepository names with NUL, for use with xargs'))],
         _('[-b] [-0] [--ignore-errors] CMD [POST-CMD]'))
}
