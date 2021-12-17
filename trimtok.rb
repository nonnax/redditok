#!/usr/bin/env ruby
# Id$ nonnax 2021-12-06 14:25:48 +0800
require 'csv'
require 'fileutils'

list=ARGV.first
list ||= 'trim.csv'

f=""

FileUtils.mkdir_p 'orig' unless Dir.exists?('orig')
begin
  CSV.foreach(list) do |row|
    f, cut_time=row
    IO.popen("fftrim.rb #{f} #{cut_time}", &:read)
    FileUtils.mv f, 'orig/'
  end
rescue => e
  p "Error reading: #{list} #{f}"
end
