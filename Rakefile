desc "Set up all the symlinks"
task :setup do
  h = ENV['HOME']
  d = Dir.pwd
  `mkdir #{h}/.bazaar`
  `rm #{h}/.bazaar/bazaar.conf`
  `ln -s #{d}/bazaar.conf #{h}/.bazaar/bazaar.conf`
  `rm #{h}/.gitconfig`
  `ln -s #{d}/gitconfig #{h}/.gitconfig`
  `rm #{h}/.zshrc`
  `ln -s #{d}/zshrc #{h}/.zshrc`
  if File.directory? quake
    if RUBY_PLATFORM.include? 'darwin'
      quake = "#{h}/Library/Application Support/QuakeLive/quakelive/home/baseq3"
    elsif RUBY_PLATFORM.include? 'linux'
      quake = "#{h}/.quakelive/quakelive/home/baseq3"
    end
    `rm '#{quake}/lol2fast4u.cfg' '#{quake}/autoexec.cfg'`
    `ln -s #{d}/lol2fast4u.cfg '#{quake}/lol2fast4u.cfg'`
    File.open("#{quake}/autoexec.cfg", 'w') {|f| f.write('exec "lol2fast4u.cfg"')}
  end
end

task :default => :setup
