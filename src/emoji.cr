require "./ppm2emoji/*"

struct Emoji
  property q1 : Pixel
  property q2 : Pixel
  property q3 : Pixel
  property q4 : Pixel
  property text : String
  property emoji : String

  def initialize(line : String)
    @q2, @q1, @q3, @q4 = colors_to_pixels line[0..23]
    @text = line[25..-1]
    @emoji = text_to_emoji @text
  end

  private def hex_to_u8(str, pos)
    str[pos, 2].to_u8(16)
  end

  private def hex_to_pixel(str, pos)
    Pixel.new(hex_to_u8(str, pos + 0), hex_to_u8(str, pos + 2), hex_to_u8(str, pos + 4))
  end

  private def colors_to_pixels(str)
    [0, 6, 12, 18].map { |i| hex_to_pixel str, i }
  end

  private def text_to_emoji(str)
    str.split('-').map(&.to_u32(16).chr).join
  end
end

i = ARGV[0].to_i
File.read_lines("emojis").each do |l|
  e = Emoji.new(l)
  e.q2.to_c; e.q1.to_c; puts " #{e.text}"
  e.q3.to_c; e.q4.to_c
  puts " #{e.emoji}"
  i -= 1
  exit if i < 0
end
