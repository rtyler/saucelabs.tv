require 'rubygems'
require 'httparty'

module SauceTV
  class API
    include HTTParty
    base_uri 'saucelabs.com/rest'

    def initialize(username, api_key)
      @auth = {:username => username, :password => api_key}
    end

    def recent_jobs
      raise NotImplemented
    end
  end
end
