require "./ppm2emoji/*"

zero = Pixel.new(0_u8, 0_u8, 0_u8)

i = (ARGV[0]? || "5000").to_i
Emoji.load do |e|
  e.q2.to_c; e.q1.to_c; puts " #{e.text}"
  e.q3.to_c; e.q4.to_c
  puts " #{e.emoji} #{zero - e.q1} #{e.q1 - zero}"
  i -= 1
  exit if i < 0
end
