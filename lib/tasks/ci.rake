require 'rspec/core/rake_task'
require 'redis'
require 'dotenv/tasks'

namespace :run_ci do
  desc 'Run rubocop with ci config'
  task rubocop: [:setup] do
    Rake::Task['rubocop'].invoke
  end

  desc 'Run rspec unit with ci config'
  task rspec_unit: [:dotenv, :setup] do
    setup_env
    RSpec::Core::RakeTask.new(:unit_spec) do |t|
      t.rspec_opts = "--exclude-pattern 'spec/features/**/*_spec.rb' "
      t.rspec_opts << '--format documentation --format html '
      t.rspec_opts << "--out #{Dir.pwd}/tmp/rspec/rspec_unit.html"
    end
    Rake::Task['unit_spec'].invoke
    flush_redis
  end

  desc 'Run rspec integration with ci config'
  task rspec_integration: [:dotenv, :setup] do
    setup_env
    RSpec::Core::RakeTask.new(:integration_spec) do |t|
      t.rspec_opts =  "--pattern 'spec/features/**/*_spec.rb' "
      t.rspec_opts << '--format documentation --format html '
      t.rspec_opts << "--out #{Dir.pwd}/tmp/rspec/rspec_integration.html"
    end
    Rake::Task['integration_spec'].invoke
    flush_redis
  end

  desc 'Setup for standard tasks'
  task :setup do
    FileUtils.rm_r("#{Dir.pwd}/tmp") if File.exist?("#{Dir.pwd}/tmp") # need it for all
    FileUtils.mkdir "#{Dir.pwd}/tmp" # need it for all
    FileUtils.mkdir "#{Dir.pwd}/tmp/rspec" # only need if for rspec
  end

  def setup_env
    ENV['RACK_ENV'] ||= 'test'
  end

  def flush_redis
    redis_url = ENV['REDIS_URL'] || 'redis://rls-jenkins.eghnul.ng.0001.euw1.cache.amazonaws.com:6379'
    Redis.new(url: redis_url).flushdb
  end
end
