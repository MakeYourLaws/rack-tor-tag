require 'rack'
require 'rack/ip'

module Rack
  class TorBlock
    
    DEFAULT_REDIRECT = 'https://sorry.google.com' #We're sorry from Google

    def initialize(app)
      @app = app
    end

    def call(env)
      return [302, {'Content-Type' => 'text', 'Location' => DEFAULT_REDIRECT}, [] ] if Rack::IP.new(env['REMOTE_ADDR']).is_tor?
        
      #Normal processing
      @app.call(env)
    end
  end
end