require 'active_support/configurable'

module Application
  include ActiveSupport::Configurable
end

Application.configure do |config|
  config.root     = File.dirname(__FILE__)
  config.env      = env.to_s
end

specific_environment = "config/environments/#{Application.config.env}.rb"

require specific_environment if File.exist? specific_environment
require File.expand_path('../application', __FILE__)

