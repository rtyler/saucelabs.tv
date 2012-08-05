require 'rubygems'
require 'httparty'

module SauceTV
  class API
    include HTTParty
    base_uri 'https://saucelabs.com/rest'

    attr_reader :username

    TIMEOUT = 5
    default_timeout TIMEOUT

    def initialize(username, api_key)
      @username = username
      @auth = {:username => username, :password => api_key}
    end

    def default_options
      {:header => {'User-Agent' => 'SauceLabs.tv',
                    'Content-Type' => 'application/json'},
        :basic_auth => @auth,
        :timeout => TIMEOUT
      }
    end

    def format
      :json
    end

    def recent_jobs
      begin
        response = self.class.get("/v1/#{username}/jobs")
      rescue Timeout::Error => e
        puts "A call to SauceTV::API#recent_jobs timed out (#{e.inspect})"
        return []
      end

      unless response.code == 200
        return []
      end

      # I believe that this should only be true if we receive non-JSON back
      # from the API. Otherwise, I *think* HTTParty will return parsed JSON
      # (Array)
      if response.body.instance_of? String
        []
      else
        response.body
      end
    end
  end
end
