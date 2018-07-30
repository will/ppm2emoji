class Array
  def grow_if_necessary(n)
    resize_to_capacity(n) if n > @capacity
    @size = @capacity
  end
end
require "./ppm2emoji/*"

# TODO: Write documentation for `Ppm2emoji`
module Ppm2emoji
  # TODO: Put your code here
end

class Player
  def initialize
    @line1 = Array(Pixel).new
    @line2 = Array(Pixel).new
    @emojis = Array(Emoji).new(3000)
    Emoji.load("good") {|e| @emojis << e}
  end

  def get_ascii_int_from_stdin
    i = 0
    loop do
      c = STDIN.read_byte.not_nil!
      break if c === '\n' || c === ' '
      i = i*10 + c.to_i - '0'.ord
    end
    i
  end

  def read_pixel
    Pixel.new STDIN.read_byte.not_nil!, STDIN.read_byte.not_nil!, STDIN.read_byte.not_nil!
  end

  def read_pixel(r)
    Pixel.new r, STDIN.read_byte.not_nil!, STDIN.read_byte.not_nil!
  end

  def read_header
    3.times { STDIN.read_byte } # P6\n header
    width = get_ascii_int_from_stdin
    height = get_ascii_int_from_stdin
    max = get_ascii_int_from_stdin
    {width, height, max}
  end

  def nearest_emoji(q2, q1, q3, q4)
    e = @emojis.first
    d = e.distance(q1, q2, q3, q4)
    @emojis.each do |this_e|
      this_d = this_e.distance(q1, q2, q3, q4)
      if this_d < d
        d = this_d
        e = this_e
      end
    end
    e.emoji
  end

  def display_emoji
    x = @line1.size
    (x/2).times do |i|
      j = i*2
      STDOUT << nearest_emoji(@line1[j], @line1[j+1], @line2[j], @line2[j+1])
    end
    puts
  end

  def display_block
    @line1.each {|p| p.to_c }
    puts
    @line2.each {|p| p.to_c }
    puts
  end

  def run(emoji)
    STDOUT.blocking = false
    loop {
      start = Time.now
      # puts "\033[2J"
      x, y, max = read_header
      @line1.grow_if_necessary(x)
      @line2.grow_if_necessary(x)
      (y/2).times {
        x.times { |i| @line1[i] = read_pixel }
        x.times { |i| @line2[i] = read_pixel }
        emoji ? display_emoji : display_block
      }
      (y%2).times { read_pixel }
      # p Time.now-start
    }
  end
end

Player.new.run(ARGV[0]? == "emoji")
