#["img-apple-160/1f1ec-1f1fc.png", "img-apple-160/0023-fe0f-20e3.png"].each {|f| process f};nil

def process(file)
  output = `ffmpeg -hide_banner -loglevel panic -i #{file} -vf scale=2:2 -f image2pipe -vcodec ppm pipe:1`
  # header = output[0..10]
  data = output[11..-1].unpack('H*').first
end

File.open("emojis", "w") do |f|
  Dir["img-apple-160/*"].each do |file|
    s = "#{process file} #{file[14..-5]}"
    puts s
    f.puts s
  end
end
