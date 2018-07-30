require "./ppm2emoji/*"
list = Set(Emoji).new
good = Set(Emoji).new
bad = Set(Emoji).new

Emoji.load { |x| list << x }
Emoji.load("good") { |x| good << x; list.delete(x) }
Emoji.load("bad") { |x| good << x; list.delete(x) }

last = "g"
list.each do |e|
  print "#{e.emoji*3}    (gbq: #{last})> "
  c = gets.not_nil!.chomp
  c = last if c == ""
  last = c
  if c == "g"
    File.write("good", e.file_line, mode: "a")
    File.write("good", "\n", mode: "a")
  elsif c == "b"
    File.write("bad", e.file_line, mode: "a")
    File.write("bad", "\n", mode: "a")
  else
    exit
  end
end
