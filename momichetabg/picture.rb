require 'fastimage'
require 'mini_magick'

puts FastImage.size("D:/Momicheta/IP/index.jpg")

#Opredelqne na razmera

# This way works on Windows

MiniMagick::Image.new("#{RAILS_ROOT}/public/data/#{D:\Momicheta\IP\index.jpg}").resize "100x100"