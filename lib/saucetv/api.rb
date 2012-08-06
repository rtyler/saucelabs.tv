require 'rubygems'
require 'httparty'

module SauceTV
  class API
    include HTTParty
    base_uri 'https://saucelabs.com/rest'

    attr_reader :username

    TIMEOUT = 5

    def initialize(username, api_key)
      @username = username
      @auth = {:username => username, :password => api_key}
    end

    def get(url)
      options = {:header => {'User-Agent' => 'SauceLabs.tv',
                    'Content-Type' => 'application/json'},
        :basic_auth => @auth,
        :timeout => TIMEOUT
      }
      self.class.get(url, options)
    end

    def format
      :json
    end

    def recent_jobs
      begin
        response = get("/v1/#{username}/jobs")
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
      if response.parsed_response.instance_of? String
        []
      else
        response.parsed_response
      end
    end
  end
end
