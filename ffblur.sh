#!/usr/bin/env bash
# Id$ nonnax 2021-11-30 10:54:39 +0800
# curl -s -H "User-agent: 'your bot 0.1'" https://www.reddit.com/r/TikTokCringe/hot.json?limit=12 | jq '.' | grep url_overridden_by_dest | grep -Eoh "https:\/\/v\.redd\.it\/\w{13}"

#!/bin/bash

for f in *.mp4;
do
  ffmpeg -i $f -lavfi '[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' -vb 800K blur/$f ;
done

# python2 $HOME/bw/.local/bin/upload.py --file="final.mp4" --title="Funny TikTok Compilation" --description="Buy my merchandise - spamlink.ly" --keywords="tiktok,cringe" --category="22" --privacyStatus="public"
