require "./ppm2emoji/*"

def hex_to_u8(str, pos)
  str[pos, 2].to_u8(16)
end

def hex_to_pixel(str, pos)
  Pixel.new(hex_to_u8(str, pos + 0), hex_to_u8(str, pos + 2), hex_to_u8(str, pos + 4))
end

def colors_to_pixels(str)
  [0, 6, 12, 18].map { |i| hex_to_pixel str, i }
end

def file_to_emoji(str)
  str.split('-').map(&.to_u32(16).chr).join
end

i = ARGV[0].to_i
File.read_lines("emojis").each do |l|
  colors = l[0..23]
  file = l[25..-1]
  px = colors_to_pixels(colors)
  px[0].to_c; px[1].to_c; puts
  px[2].to_c; px[3].to_c
  puts " #{file_to_emoji file}"
  i -= 1
  exit if i < 0
end
