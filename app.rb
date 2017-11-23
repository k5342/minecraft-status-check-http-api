require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/config_file'

require_relative 'lib/minecraft-socket/lib/minecraft-socket.rb'

class App < Sinatra::Base
  register Sinatra::ConfigFile
  config_file './config.yml'
  
  def fetch_status(host, port = 25565)
    result = {
      body: {},
      last_checked_at: Time.now
    }
    
    begin
      s = Minecraft::Session.new(host, port, 3)
      d = s.fetch_status
      
      result[:status] = :online
      result[:body] = d[:data]
    rescue StandardError => e
      result[:status] = :offline
      result[:body] = {
        error: e.class,
        detail: e.to_s,
      }
    end
    
    result
  end
  
  get '/' do
    result = {}
    
    settings.servers.each do |e|
      server_name, server_host, server_port = e[:name], e[:host], e[:port]
      result[server_name] = fetch_status(server_host, server_port)
    end
    
    json result
  end
end
