
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  $LOAD_PATH.concat(Dir.glob("#{global_gemset}/gems/*/lib")) if
  global_gemset
end; nil

require 'awesome_print'
require 'pry'
require 'pry-byebug'
require 'httplog'
require 'json'

HttpLog.configure do |config|
  # Enable or disable all logging
  config.enabled = true

  # You can assign a different logger or method to call on that logger
  config.logger = Logger.new($stdout)
  config.logger_method = :log

  # I really wouldn't change this...
  config.severity = Logger::Severity::DEBUG

  # Tweak which parts of the HTTP cycle to log...
  config.log_connect   = true
  config.log_request   = true
  config.log_headers   = true
  config.log_data      = true
  config.log_status    = true
  config.log_response  = true
  config.log_benchmark = true

  # ...or log all request as a single line by setting this to `true`
  config.compact_log = false

  # You can also log in JSON format
  config.json_log = false

  # Prettify the output - see below
  config.color = :cyan

  # Limit logging based on URL patterns
  config.url_whitelist_pattern = nil
  config.url_blacklist_pattern = nil

  # You can specify any custom JSON serializer that implements `load` and `dump` class methods
  # to parse JSON responses
  # config.json_parser = JSON

  # Mask the values of sensitive requestparameters
  config.filter_parameters = %w[password]
end

def enable_http_logging(settings={})
  HttpLog.config.enabled = true

  settings.each do |k,v|
    HttpLog.config.send("#{k}=".to_sym, v)
  end
end

def disable_http_logging
  HttpLog.config.enabled = false
end
