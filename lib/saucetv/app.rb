require 'rubygems'

require 'haml'
require 'sinatra'
require 'saucetv/api'
require 'saucetv/errors'

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
      invalid = !(params['invalid'].nil?)
      haml :login, :locals => {:invalid => invalid}
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
      jobs = []

      begin
        jobs = api.recent_jobs
      rescue SauceTV::InvalidUserCredentials
        redirect to('/login?invalid=true')
      end

      haml :watch, :locals => {
        :username => session[:username],
        :jobs => jobs
      }
    end

  end
end
