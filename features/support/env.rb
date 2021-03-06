require 'capybara'
require 'capybara/cucumber'
require 'rack/test'
require 'cucumber/rspec/doubles'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../../lib')

require 'saucetv/app'
require 'saucetv/api'
require 'saucetv/errors'

Capybara.app = SauceTV::Application
