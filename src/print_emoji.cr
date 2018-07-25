require "./ppm2emoji/*"

i = (ARGV[0]? || "5000").to_i
Emoji.load do |e|
  e.q2.to_c; e.q1.to_c; puts " #{e.text}"
  e.q3.to_c; e.q4.to_c
  puts " #{e.emoji}"
  i -= 1
  exit if i < 0
end
