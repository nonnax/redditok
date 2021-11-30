#!/usr/bin/env ruby
# Id$ nonnax 2021-11-30 11:34:50 +0800
require 'rubytools/fzf'
arr=Dir['*.mp*'].fzf

arr.each do |e|
  pid=fork do
      IO.popen("ffblur.sh #{e}", &:read)
  end
  begin
    Timeout.timeout(20) do
        Process.wait
    end
  rescue Timeout::Error
    Process.kill 9, pid
    # collect status so it doesn't stick around as zombie process
    Process.wait pid
  end
end
