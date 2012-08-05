
module UserCredentials
  def has_valid_credentials?
    filepath = File.join(Dir.pwd, 'ondemand.yml')
    unless File.exists? filepath
      raise Exception, 'Please place an ondemand.yml in the project root to run tests'
    end

    @credentials = YAML.load_file(filepath)
  end

  def invalidate!
    @credentials = {}
  end

  def username
    @credentials['username'] || 'anonymous'
  end

  def api_key
    @credentials['api_key'] || 'anonymous'
  end
end

World(UserCredentials)
