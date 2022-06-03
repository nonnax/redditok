#!/usr/bin/env ruby
# Id$ nonnax 2022-06-03 13:40:48 +0800
f,=ARGV

cmd=<<~___
ffmpeg -i '#{f}' -lavfi 
'[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' 
-vb 800K 'blur_#{f}'
___

cmd.gsub!(/\n{1,}/,' ')
puts cmd
