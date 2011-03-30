define_lastfm_webjumps(get_pref("lastfm_username"));

define_webjump("reddit", "http://reddit.com/search?q=%s");
define_webjump("github", "https://github.com/search?type=Repositories&q=%s");
define_webjump("bitbucket", "https://bitbucket.org/repo/all?name=%s");
define_webjump("codesearch", "http://www.google.com/codesearch?q=%s");
define_webjump("debianwiki",
    "http://wiki.debian.org/Suspend?action=fullsearch&context=180&value=%s&fullsearch=Text");


define_webjump("down?",
  function (url) {
    if (url) {
      return "http://downforeveryoneorjustme.com/" + url;
    } else {
      return "javascript:window.location.href='http://downforeveryoneorjustme.com/'+window.location.href;";
    }
  },
  $argument = "optional",
  $completer = history_completer($use_history = false, $use_bookmarks = true));

define_webjump("wayback",
  function (url) {
    if (url) {
      return "http://web.archive.org/web/*/" + url;
    } else {
      return "javascript:window.location.href='http://web.archive.org/web/*/'+window.location.href;";
    }
  },
  $argument = "optional",
  $completer = history_completer($use_history = false, $use_bookmarks = true));