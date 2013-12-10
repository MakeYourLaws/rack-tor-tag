require 'resolv'

module Rack
  class IP
    
    TOR_POSITIVE_IP = '127.0.0.2' #In case the DNS look up is positive, this is the IP address returned
    TOR_DNSEL = 'ip-port.exitlist.torproject.org' #https://www.torproject.org/projects/tordnsel.html.en
    
    GOOGLE_DNS_ADDR = '8.8.8.8'
    GOOGLE_DNS_PORT = '53'
    
    # client_addr is the address of the remote client we want to test to be an TOR node
    # server_addr is the address of a public IP server we want to reach passing through client_addr
    # server_port is a TCP port running on server_addr to test for positiviness to TOR network
    def initialize(client_addr, server_addr = GOOGLE_DNS_ADDR, server_port=GOOGLE_DNS_PORT)
      @client_addr, @server_port, @server_addr = client_addr.to_s, server_port.to_s, server_addr.to_s
    end
    
    def is_tor? #Implements https://www.torproject.org/projects/tordnsel.html.en
      Resolv.getaddress(tor_hostname) == TOR_POSITIVE_IP
    rescue Errno::EHOSTUNREACH, Errno::ENETUNREACH, Resolv::ResolvError => e
      false
    end
    
    def tor_hostname
      [reverse_ip_octets(@client_addr), @server_port, reverse_ip_octets(@server_addr), TOR_DNSEL].join('.')
    end

    def reverse_ip_octets(ip)
      ip.split('.').reverse.join('.')
    end
    
  end
end