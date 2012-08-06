require 'rspec'
require 'rack/test'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../../lib')

require 'saucetv/api'
require 'saucetv/errors'
