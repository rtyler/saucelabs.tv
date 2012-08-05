require 'capybara'
require 'capybara/cucumber'
require 'rack/test'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../../lib')

require 'saucetv/app'
require 'saucetv/api'

Capybara.app = SauceTV::Application
