# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

set -gx RUBY_HEAP_MIN_SLOTS 1000000
set -gx RUBY_HEAP_SLOTS_INCREMENT 1000000
set -gx RUBY_HEAP_SLOTS_GROWTH_FACTOR 1
set -gx RUBY_GC_MALLOC_LIMIT 1000000000
set -gx RUBY_HEAP_FREE_MIN 500000
set PATH "$HOME/.rbenv/bin" $PATH
set PATH "$HOME/.rbenv/shims" $PATH
rbenv rehash 2>/dev/null
