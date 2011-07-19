require 'rubygems'

IRB.conf[:USE_READLINE] = true
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:PROMPT_MODE]  = :SIMPLE

begin
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

begin
  require 'sketches'
  Sketches.config :editor => 'vim'
rescue LoadError => err
  warn "Couldn't load Sketches: #{err}"
end

begin
  require 'hirb'
  require 'hirb/import_object'
  Hirb.enable
  extend Hirb::Console
rescue LoadError => err
  warn "Couldn't load Hirb: #{err}"
end

begin
  require 'ap'
rescue LoadError => err
  warn "Couldn't load awesome_print: #{err}"
end
