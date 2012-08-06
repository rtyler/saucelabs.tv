require 'rubygems'

require 'haml'
require 'sinatra'
require 'saucetv/api'
require 'saucetv/errors'

module SauceTV
  class Application < Sinatra::Base
    enable :sessions
    set :public_folder, File.expand_path(File.dirname(__FILE__) + '/../../public')

    def authenticated?
      session[:username] && session[:api_key]
    end

    helpers do
      def api_for_session
        SauceTV::API.new(session[:username], session[:api_key])
      end
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

    get '/next/after/:id' do |id|
      unless authenticated?
        redirect to('/login')
      end

      api = api_for_session
      jobs = []
      begin
        jobs =api.recent_jobs
      rescue SauceTV::InvalidUserCredentials
        redirect to('/login?invalid=true')
      end

      if jobs.empty?
        redirect to('/watch')
      end

      previous = nil
      jobs.each do |job|
        break if id == job['id']
        previous = job
      end

      unless previous.nil?
        redirect to("/watch/#{previous['id']}")
      end
      redirect to('/watch')
    end

    get '/watch/:id' do |id|
      unless authenticated?
        redirect to('/login')
      end

      api = api_for_session
      begin
        info = api.info_for(id)
      rescue SauceTV::InvalidUserCredentials
        redirect to('/login?invalid=true')
      end

      haml :player, :locals => {
        :username => session[:username],
        :id => id,
        :delay => info['end_time'] - info['start_time'],
        :info => info,
        :token => api.auth_token_for(id)
      }
    end

    get '/watch' do
      unless authenticated?
        redirect to('/login')
      end

      api = api_for_session
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
