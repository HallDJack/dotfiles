require 'rubygems'
require 'awesome_print'
require 'irb/ext/save-history'

p "hello"

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/Code/.irb_history"