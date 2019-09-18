#! /bin/sh

curl localhost:1500 >.tmp.json 2>/dev/null

ipm=`cat .tmp.json | python2.7 -c 'import sys; import json; j=json.loads(sys.stdin.read()); print([h["main_ip"] for h in [j[k] for k in j.keys()] if h["OSID"] == "270"][0])'`
ipw1=`curl .tmp.json | python2.7 -c 'import sys; import json; j=json.loads(sys.stdin.read()); print([h["main_ip"] for h in [j[k] for k in j.keys()] if h["OSID"] == "270"][1])'`

perl -pe "s/MASTER/${ipm}/;s/WORKER/${ipw1}/" < hosts.templ > hosts
