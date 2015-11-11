Application.configure do |config|
  config.redis_url = ENV['REDIS_URL']
end
