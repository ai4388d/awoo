require 'mini_magick'
# this is not recommended
Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8
#Fonts = %x[convert -list font].split("\n")
#Fonts = %w(ZXX-Camo ZXX-Noise ZXX-Xed)
Fonts = %w(ZXX-Noise ZXX-Xed)
#Fonts.select! do |f| f.strip.split[0] == "Font:" end.map! do |f| f.strip.split[1] end
Wordlist = "/usr/share/dict/words"
Words = File.read(Wordlist).split("\n").select! do |w| !w.include?("'") && w.length <= 5 && w.length >= 3 end.map! do |w| w.downcase end
def make_text
	rr = ->() do
		127 + Random.rand(127);
	end
	text = "#{Words.sample} #{Words.sample} #{Words.sample}"
	font = Fonts.sample
	realtext = ""
	text.each_codepoint do |x|
		# keep only ascii lowercase letters and spaces
		# sometimes something comes along with an é or ñ or something and
		# it shows up as a question mark in the zxx font, and nobody can type the captcha
		if (x >= 97 && x <= 122) || x == 0x20
			realtext += x.chr
		end
	end
	filename = "/dev/shm/#{realtext}.png"
	MiniMagick::Tool::Convert.new do |img|
		img.size "450x60"
		img << "xc:black"
		img.fill "rgb(#{rr.call}, #{rr.call}, #{rr.call})"
		#img.stroke "rgb(#{rr.call}, #{rr.call}, #{rr.call})"
		img.pointsize "40"
		img.gravity "center"
		img.font font
		img.draw "text 0,0 '#{realtext}'"
		img << filename
	end
	bytes = File.read filename
	File.delete filename
	return [text, bytes]
end
