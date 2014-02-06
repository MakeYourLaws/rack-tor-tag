require 'rack'
require 'resolv'

module Rack
  class TorTag
    DEFAULT_PARAMS = {
      # You could run your own if you want.
      # https://www.torproject.org/projects/tordnsel.html.en
      :dnsel => 'ip-port.exitlist.torproject.org', 
      :host_ips => nil, # will get from env
      :host_port => nil
    }
    
    def initialize(app, params = {})
      @app = app
      @params = DEFAULT_PARAMS.merge(params)
    end

    def call(env)
      ip = env['action_dispatch.remote_ip']
      # Getting the right IP is hard. Let's punt. 
      # http://api.rubyonrails.org/classes/ActionDispatch/RemoteIp.html
      # http://blog.gingerlime.com/2012/rails-ip-spoofing-vulnerabilities-and-protection/
      raise 'Must run after ActionDispatch::RemoteIp' if ip.blank?
      
      case is_tor?(ip, env)
      when true
        env['tor'] = true
        env['tor_ip'] = ip # stick it elsewhere
        env['action_dispatch.remote_ip'] = '127.0.0.2' # make all Tor IPs look alike
      when false
        env['tor'] = false
      else
        env['tor'] = nil # i.e. unknown
      end
      
      # Continue normal processing
      @app.call(env)
    end
    
    protected
    
    # see https://www.torproject.org/projects/tordnsel.html.en
    def is_tor? ip, env
      # We're a hidden service! Of course it's Tor.
      return true if env['HTTP_HOST'] =~ /\.onion\z/ 
      
      host_ips = @params[:host_ips] || Resolv.getaddresses(
        env['HTTP_HOST'] ? env['HTTP_HOST'].sub(/:.*/,'') : env['SERVER_NAME']).
      select{|i| i[Resolv::IPv4::Regex]} # DNEL only works with IPv4
      
      host_ips.each do |host_ip| 
        tor_hostname = [reverse_ip_octets(ip), @params[:host_port] || env['SERVER_PORT'], reverse_ip_octets(host_ip), @params[:dnsel]].join('.')
        begin
          return true if (Resolv.getaddress(tor_hostname) == '127.0.0.2')
        rescue Resolv::ResolvError => e
          false # It's supposed to not get a response if it's not a tor host
        end
      end
      false
    
    rescue Errno::EHOSTUNREACH, Errno::ENETUNREACH => e
      return nil      
    end
    
    def reverse_ip_octets(ip)
      ip.to_s.split('.').reverse.join('.')
    end
  end
end