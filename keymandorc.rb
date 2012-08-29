# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

# Functions ------------------------------------------------------------
def colemak(s)
  # keymando works as if it's on qwerty
  # even if i'm using colemak
  s.tr("qwfpgjluy;arstdhneiozxcvbkmQWFPGJLUY;ARSTDHNEIOZXCVBKM",
       "qwertyuiopasdfghjkl;zxcvbnmQWERTYUIOPASDFGHJKL;ZXCVBNM")
end

def ctrlshift(k, &block)
  map "<Ctrl-Shift-#{colemak k}>", block
end

# Apps -----------------------------------------------------------------
$browser = "Google Chrome"
$term = "iTerm"

# Basic settings -------------------------------------------------------
start_at_login
disable "Remote Desktop Connection"
disable /VirtualBox/

# App switching --------------------------------------------------------
ctrlshift "n" { activate $browser }
ctrlshift "e" { activate $term }
ctrlshift "i" { activate "ForkLift" }
ctrlshift "o" { activate "MacVim" }
ctrlshift "y" { activate "Pixelmator" }
ctrlshift "m" { activate "Messages" }
ctrlshift "/" { activate "WrapTunes"; send "<Cmd-0>" }

# Automation -----------------------------------------------------------
ctrlshift ";" {
  activate $browser
  sleep 1
  send "<Cmd-#{colemak "r"}>"
  sleep 1
  activate $term
}
