
module SauceTV
  class API
    attr_accessor :username
    attr_writer :api_key

    def initialize(username, api_key)
      @username = username
      @api_key = api_key
    end

    def recent_jobs
      []
    end
  end
end
