# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require File.join PADRINO_ROOT, 'lib', 'mpd'
Bundler.require(:default, PADRINO_ENV)

##
# Enable devel logging
#
# Padrino::Logger::Config[:development] = { :log_level => :devel, :stream => :stdout }
# Padrino::Logger::Config[:development][:log_static] = true
#
Sprockets.append_path('lib/assets')

##
# Add your before load hooks here
#
Padrino.before_load do
  $mpd = MPDControl.new
end

##
# Add your after load hooks here
#
Padrino.after_load do
  Encoding.default_internal = nil # fixes haml partials encoding bug
end

Padrino.load!
