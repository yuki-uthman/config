#!/usr/bin/env ruby

status = `pmset -g batt | sed -n 2p | cut -d ';' -f 2 | tr -d " "`.rstrip
percent = `pmset -g batt | grep -Eo '[0-9]?[0-9]?[0-9]%'`.rstrip
remaining = `pmset -g batt | grep -Eo '[0-9]?[0-9]:[0-9][0-9]'`.rstrip

icon =
  case status
  when "discharging"
    "🔋"
  when "charging"
    "⚡️"
  else
    "⚡️"
  end

remaining = remaining.empty? ? "0:00" : remaining

puts "#{icon} #{remaining} (#{percent})"
