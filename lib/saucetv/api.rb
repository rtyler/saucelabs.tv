require 'rubygems'
require 'httparty'

module SauceTV
  class API
    include HTTParty
    base_uri 'https://saucelabs.com/rest'

    attr_reader :username

    def initialize(username, api_key)
      @username = username
      @auth = {:username => username, :password => api_key}
    end

    def default_timeout
      5
    end

    def default_options
      {:header => {'User-Agent' => 'SauceLabs.tv',
                    'Content-Type' => 'application/json'},
        :basic_auth => @auth
      }
    end

    def format
      :json
    end

    def recent_jobs
      begin
        response = self.class.get("/v1/#{username}/jobs")
      rescue Timeout::Error => e
        puts e.inspect
        return []
      end

      unless response.code == 200
        return []
      end
      response.body
    end
  end
end
