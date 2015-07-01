[![Build Status](https://travis-ci.org/MakeYourLaws/rack-tor-tag.svg)](https://travis-ci.org/MakeYourLaws/rack-tor-tag)
[![Gem Version](https://badge.fury.io/rb/rack-tor-tag.svg)](http://badge.fury.io/rb/rack-tor-tag)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/MakeYourLaws/rack-tor-tag/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/MakeYourLaws/rack-tor-tag/?branch=master)
[![security](https://hakiri.io/github/MakeYourLaws/rack-tor-tag/master.svg)](https://hakiri.io/github/MakeYourLaws/rack-tor-tag/master)
[![Code Climate](https://codeclimate.com/github/MakeYourLaws/rack-tor-tag/badges/gpa.svg)](https://codeclimate.com/github/MakeYourLaws/rack-tor-tag)
[![Test Coverage](https://codeclimate.com/github/MakeYourLaws/rack-tor-tag/badges/coverage.svg)](https://codeclimate.com/github/MakeYourLaws/rack-tor-tag/coverage)
[![Dependency Status](https://gemnasium.com/MakeYourLaws/rack-tor-tag.svg)](https://gemnasium.com/MakeYourLaws/rack-tor-tag)

# rack-tor-tag

A rack middleware to tag accesses to your rails application from TOR nodes. 

Based on [https://github.com/Gild/rack-tor-block]

## Install

Gemfile:

    gem 'rack-tor-tag'

config/appplication.rb:

    config.middleware.insert_after ActionDispatch::RemoteIp, Rack::TorTag
    # or set config params
    config.middleware.insert_after ActionDispatch::RemoteIp, Rack::TorTag, :host_ips => %w(1.2.3.4 1.2.3.5), :dnsel => 'my-dnsel-instance.myhost.org', :hostport => '123'

By default, `:host_ips` will be gotten by DNS lookup on `HTTP_HOST`, so if you know your IPs it's more efficient to specify. `:host_port` should probably be left blank, in which case it'll be gotten from `SERVER_PORT`.

`:dnsel` is if you're running your own instance of the [Tor DNS Exit List software](https://www.torproject.org/projects/tordnsel.html.en).

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
