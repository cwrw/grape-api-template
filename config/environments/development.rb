Application.configure do |config|
  config.redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379/1'
end
