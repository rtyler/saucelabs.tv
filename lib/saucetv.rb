require 'sinatra'


module SauceTV
  class Application < Sinatra::Base
    get '/' do
      'Welcome to SauceLabs.tv'
    end
  end
end
