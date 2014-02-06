# rack-tor-tag

A rack middleware to tag accesses to your rails application from TOR nodes. 

Based on [https://github.com/Gild/rack-tor-block]

## Install

Gemfile:

    gem 'rack-tor-tag'

config/appplication.rb:

    config.middleware.insert_after ActionDispatch::RemoteIp, Rack::TorTag

## Use

Tor users will all have `env['action_dispatch.remote_ip'] = '127.0.0.2'`. The actual source IP is at `env['tor_ip']` — though practically all Tor IPs should probably be treated the same, since there's no easy way to know whether two different Tor exit node IPs represent the same originating user or not.

`env['tor']` will be true for Tor users, false for non-Tor users, and nil if the lookup failed.

## Todo

[ ] Get the bulk list rather than doing DNS lookups
[ ] Cache results
[ ] Local-cache dns lookups

## Contributing
 
* Fork
* Open an issue
* Commit, push, Pull Req
* Check the status of the existing tests / add new tests