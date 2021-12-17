#!/usr/bin/env ruby
# Id$ nonnax 2021-12-07 16:22:02 +0800
require 'optparse'

@options = {}

OptionParser.new do |opts|
  opts.on("-v", "--verbose", "Show extra information") do
    @options[:verbose] = true
  end

  opts.on("-c", "--color", "Enable syntax highlighting") do
    @options[:syntax_highlighting] = true
  end
end.parse!

p @options
