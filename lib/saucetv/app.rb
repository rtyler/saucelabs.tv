require 'rubygems'

require 'haml'
require 'sinatra'
require 'saucetv/api'

module SauceTV
  class Application < Sinatra::Base
    enable :sessions

    def authenticated?
      session[:username] && session[:api_key]
    end

    get '/' do
      'Welcome to SauceLabs.tv'
    end

    get '/login' do
      haml :login
    end

    post '/login' do
      session[:username] = params[:username]
      session[:api_key] = params[:api_key]
      redirect to('/watch')
    end

    get '/watch' do
      unless authenticated?
        redirect to('/login')
      end

      api = SauceTV::API.new(session[:username], session[:api_key])

      haml :watch, :locals => {
        :username => session[:username],
        :jobs => api.recent_jobs
      }
    end

  end
end
