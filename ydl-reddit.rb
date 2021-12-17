#!/usr/bin/env ruby
# Id$ nonnax 2021-11-30 10:54:39 +0800
# curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/TikTokCringe/hot.json?limit=12 | jq '.' | grep url_overridden_by_dest | grep -Eoh "https:\/\/v\.redd\.it\/\w{13}"
require 'excon'
require 'json'
# youtube-dl $(curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/TikTokCringe/hot.json?limit=100 | jq '.' | grep url_overridden_by_dest | grep -Eoh "https:\/\/v\.redd\.it\/\w{13}")

def get(after, limit=100)
  url="https://www.reddit.com/r/TikTokCringe/hot.json?limit=#{limit}"
  url="https://www.reddit.com/r/TikTokCringe/hot.json?limit=#{limit}&after=#{after}" if after
  res=Excon.get(
    url,
    headers: {
      'User-agent' => 'your bot 0.1'
    }
  )  
  data=JSON.parse(res.body)
  [data.dig('data', 'after'), data.dig( 'data', 'children')]
end

after=nil
listing=[]

1.times do |i|
  after, data=get(after)
  p after
  listing+=data
end

File.open('after.txt', 'a'){|f| f.puts [Time.now.to_s, 'after', after].join(',')}

t=[]
listing.each_with_index do |v, i|
  t<<Thread.new(i, v) do |i, v|
    line=v.dig('data', 'url_overridden_by_dest')
    p line if /redd\.it/.match(line)
    sleep 1
  end
end
t.map(&:join)
