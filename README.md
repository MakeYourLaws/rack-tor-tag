# rack-tor-block

A rack middleware to block accesses to your rails application from TOR nodes. Inspired by [https://github.com/udzura/rack-block]

## Install

  $ gem install rack-tor-block

Depends on `rack` >= 1.3.

## Usage

You need to add this Rack application in your Rack stack.
If you're using Rails, simply add the following line to your config/application.rb (in the class block):

   config.middleware.insert_after ActionDispatch::RemoteIp, Rack::TorBlock

## Todo

## Contributing
 
* Fork
* Open an issue
* Commit, push, Pull Req
* Check the status of the existing tests / add new tests