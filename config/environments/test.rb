Application.configure do |config|
  config.redis_url = ENV['REDIS_URL'] || 'redis://rls-jenkins.eghnul.ng.0001.euw1.cache.amazonaws.com:6379'
end
