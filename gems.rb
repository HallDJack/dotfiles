
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  $LOAD_PATH.concat(Dir.glob("#{global_gemset}/gems/*/lib")) if
  global_gemset
end

require 'awesome_print'
require 'pry'
require 'pry-byebug'
