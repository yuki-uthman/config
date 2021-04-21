#!/usr/bin/env ruby
require "date"

# os
# 26 🚨
#
# database
# 27
# 11/may 🚨
# 20/may

os_midterm = Date.new(2021, 4, 26)

database1 = Date.new(2021, 4, 27)
database2 = Date.new(2021, 5, 20)
database_project = Date.new(2021, 6, 10)
database_midterm = Date.new(2021, 5, 11)

arr = []
arr.push os_midterm
arr.push database1
arr.push database2
arr.push database_midterm
arr.push database_project

dates = arr.map {|date| (date - Date.today).to_i }.sort

dates.take(3).each do |date|
  print "#{date} "
end
