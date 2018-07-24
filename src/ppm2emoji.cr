require "./ppm2emoji/*"

# TODO: Write documentation for `Ppm2emoji`
module Ppm2emoji
  # TODO: Put your code here
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

loop {
  puts "\033[2J"
  x, y, max = read_header
  (y).times {
    x.times {
      c = STDIN.read_byte
      read_pixel(c.not_nil!).to_c
    }
    puts
  }
  sleep 0.1
}
