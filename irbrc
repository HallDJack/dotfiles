require 'rubygems'
require 'awesome_print'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/Code/.irb_history"

def show_sql_commands
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end
