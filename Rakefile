require 'bundler'

Bundler.setup(:default, :development, :test)

# Load all the tasks in lib/tasks
Dir['lib/tasks/*.rake'].each { |file| Rake.load_rakefile file }

require 'grape-raketasks'
require 'grape-raketasks/tasks'
desc 'load the Grape environment.'
task :environment do
  require File.expand_path('config/environment', __FILE__)
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: [:rubocop, :spec]
