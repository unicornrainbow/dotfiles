# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

# keymando works as if it's on qwerty
# even if i'm using colemak
def colemak(s)
  s.tr("qwfpgjluy;arstdhneiozxcvbkmQWFPGJLUY;ARSTDHNEIOZXCVBKM", "qwertyuiopasdfghjkl;zxcvbnmQWERTYUIOPASDFGHJKL;ZXCVBNM")
end

$browser = "Google Chrome"
$term = "iTerm"

# Stuff ----------------------------------------------------------------
start_at_login
disable "Remote Desktop Connection"
disable /VirtualBox/

map "<Ctrl-Shift-#{colemak "r"}>" { reload }

# App switching --------------------------------------------------------
map "<Ctrl-Shift-#{colemak "n"}>" { activate $browser }
map "<Ctrl-Shift-#{colemak "e"}>" { activate $term }
map "<Ctrl-Shift-#{colemak "i"}>" { activate "ForkLift" }
map "<Ctrl-Shift-#{colemak "o"}>" { activate "MacVim" }
map "<Ctrl-Shift-#{colemak "y"}>" { activate "Pixelmator" }
map "<Ctrl-Shift-m>" { activate "Messages" }

# Automation -----------------------------------------------------------
map "<Ctrl-Shift-#{colemak ";"}>" {
  activate $browser
  sleep 1
  send "<Cmd-#{colemak "r"}>"
  sleep 1
  activate $term
}
