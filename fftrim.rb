#!/usr/bin/env ruby
# Id$ nonnax 2022-06-03 13:36:40 +0800
f, cuttime = ARGV
cmd=<<~___
ffmpeg -i '#{f}' -to #{cuttime} -c:copy 'cut_#{f}'
___

puts cmd

# IO.popen(cmd, &:read)
