dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
$TESTING = true

require 'batting_stats'
require 'minitest/autorun'
require 'mocha/setup'
