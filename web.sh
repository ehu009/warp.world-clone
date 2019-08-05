#!/bin/sh

iptables -t nat -A OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 3000

su - rails <<!
cd /home/eirik/warp.world-clone

RAILS_ENV=production
bundle exec rake assets:precompile
#RAILS_LOG_TO_STDOUT=yes
rails s -b 0.0.0.0 -e production

exit
!
