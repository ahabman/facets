#!/usr/bin/env ruby
require 'csv'

csv_file = ARGV.shift
headers = ARGV

# to run:
# ./facets.rb file.csv ColumnHeader
#
# output:
# ColumnHeader
# -------
# 579 : Female
# 575 : Male
#
#
# {
#   'header_1': {
#     'value_1': 350,
#     'value_2': 279,
#     'value_3': 182,
#   },
#   'header_2': {
#     'value_1': 92,
#     'value_2': 78,
#     'value_3': 56,
#   },
# }
#
# Header_1
# -----------------
# value_1: 350
# value_2: 279
#

facets = {}
output = ""
rows = 0
headers.each do |header|

  facets[header] = {}
  CSV.foreach(csv_file, {:headers => true}) do |row|
    value = row.fetch(header)
    if(facets[header][value])
      facets[header][value] += 1
    else
      facets[header][value] = 1
    end
    rows += 1
  end

end

puts "\n #{rows} rows \n"
facets.each_pair do |column, value_and_count|
  
  puts column
  puts '-------'
  value_and_count = value_and_count.to_a.sort_by{|a| a[1] }.reverse
  value_and_count.each do |v|
    puts  v[1].to_s + "\t: " + v[0].to_s
  end
  puts "\n"

end