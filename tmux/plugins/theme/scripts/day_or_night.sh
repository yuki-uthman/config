#!/usr/bin/env ruby

require "gemoji"
require "hijri"

def get_moon(day)
  case day
  when 1..2
    "new_moon"
  when 3..5
    "waxing_crescent_moon"
  when 6..9
    "first_quarter_moon"
  when 10..12
    "waxing_gibbous_moon"
  when 13..15
    "full_moon"
  when 16..19
    "waning_gibbous_moon"
  when 20..23
    "last_quarter_moon"
  when 24..27
    "waning_crescent_moon"
  when 28..30
    "new_moon"
  else
    "mag"
  end
end

time = Time.new
hour = time.hour
min = time.min
today = Hijri::Date.today.day

emoji =
  case hour
  when 0..6
    get_moon(today)
  when 7..18
    "sunny"
  when 19
    if min <= 30
      "sunny"
    else
      get_moon(today)
    end
  when 20..23
    get_moon(today)
  else
    "mag"
  end

puts Emoji.find_by_alias(emoji).raw
