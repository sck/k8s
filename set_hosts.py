#! /usr/bin/python3.6
import subprocess
import json
import re

r=subprocess.run(['curl', 'localhost:1500'], 
  stdout=subprocess.PIPE, stderr=subprocess.PIPE)

j=json.loads(r.stdout)
ips=[h["main_ip"] for h in [j[k] for k in sorted(j.keys())] if h["OSID"] == "270"]
master=ips.pop(0)

workers_s = "\n".join([f"worker{i+1} ansible_host={ip}  ansible_user=root" for i, ip in enumerate(ips)])

open("hosts", "w").write(re.sub(r'WORKERS', workers_s, re.sub(r'MASTER', master, open("hosts.templ").read())))

