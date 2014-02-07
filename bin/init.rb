require 'fileutils'

targets = File.expand_path("~/dotfiles/*")

p targets

puts 'Make Symblic Link'
Dir::glob(targets).each do  |target|
  if m = target.match(/\/_(.*)/)
    cmd = "ln -fs #{target} ~/.#{m[1]}"
    p cmd
    system cmd
  end
end

puts 'Submodule Initialize' 
Dir::chdir(File.expand_path('~/dotfiles'))
#exec 'pwd'
system 'git submodule update --init'

puts 'finish'
