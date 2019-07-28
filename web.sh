#!/bin/sh
iptables -t nat -A OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 3000
su - rails <<!
cd /home/eirik/warp.world-clone
whoami
rails s -b 0.0.0.0

echo "fire on my penis"
exit
!
