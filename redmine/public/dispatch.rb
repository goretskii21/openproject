#!e:/ruby/bin/ruby
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require "dispatcher"
ADDITIONAL_LOAD_PATHS.reverse.each { |dir| $:.unshift(dir) if File.directory?(dir) } if defined?(Apache::RubyRun)
Dispatcher.dispatch
