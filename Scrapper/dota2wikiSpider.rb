#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'open-uri'
require 'pp'
require 'ostruct'
require 'net/http'




heroArray = Array.new

class Hero
	def initialize()
		@data = Hash.new { |hash, key| hash[key] = [] }
	end
	def [](key)
		@data[key]
	end
	def []=(key,words)
		@data[key] += [words].flatten
		@data[key].uniq!
	end
	def getKeys
		return @data.keys
	end
	def to_json(*a)
		@data.to_json(*a)
	end
end


class Skill
	def initialize()
		@data = Hash.new { |hash, key| hash[key] = [] }
	end
	def [](key)
		@data[key]
	end
	def []=(key,words)
		@data[key] += [words].flatten
		@data[key].uniq!
	end
	def getKeys
		return @data.keys
	end
	def to_json(*a)
		@data.to_json(*a)
	end
end



def try_get_image_with_names(potentialnamearray,foldername,filename)
	localimgpath = "images/#{foldername}/default_icon.png"
	imageurl = 'http://www.dota2wiki.com/wiki/File:'
	potentialnamearray.each do |hname|
		cleanedname = hname.strip.gsub(/\s+/,"_")
		heroimagurl = "#{imageurl}#{cleanedname}.png"
		localimgpath = get_image_at_page(heroimagurl,foldername,filename)
		break if localimgpath != "images/#{foldername}/default_icon.png"
	end
	return localimgpath
	
end

def get_image_at_page(imgpageurl,foldername,filename)

puts "Requesting Image from '#{imgpageurl}'"

	getimgurl = /external free\"\shref="(.*?)\"/m
	getimgurltwo = /class\=\"fullMedia\"><a\shref\=\"(.*?)"/m
	basenormalurl = 'http://www.dota2wiki.com/'
	localimgpath = "images/#{foldername}/#{filename}"

	begin
		heroimgsource = open(imgpageurl){|f|f.read} #Get the image page	
		heroimgsource.scan(getimgurltwo){|heroimgurl|
			begin
				if FileTest.exists?(localimgpath)
					puts "File Found locally"
					return localimgpath
				end

				open(localimgpath, 'wb') do |file|
					puts "Downloading: #{heroimgurl}"
					file << open("#{basenormalurl}#{heroimgurl.first}").read
				end
				return localimgpath;
			rescue Exception=>e
				puts "Download img Error:#{e}"
				return "images/#{foldername}/default_icon.png"
			end
		}
	rescue Exception=>e
		puts "Fetch Image Page URL Error:#{e}"
		return "images/#{foldername}/default_icon.png"
	end
end

def get_hero_icon(h)

	heroname = h['name']
	puts "		>Geting Hero Icon"

	getheroiconurl = /src\=\"(.*?_icon.png)\"/m
	basenormalurl = 'http://www.dota2wiki.com/'
	cleanedname = heroname.first.strip.gsub(/\s+/,"_")

	source = open("#{basenormalurl}wiki/#{cleanedname}"){|f|f.read} #Get the export

	potentialiconpaths = source.scan(/src\=\"(.*?#{cleanedname}_icon.png)\"/i)
	iconpath= potentialiconpaths.first;

	localimgpath = "images/heroiconimg/#{cleanedname}_icon.png"

	begin

		if FileTest.exists?(localimgpath)
					puts "File Found locally"
					return localimgpath
				end

			open(localimgpath, 'wb') do |file|
				puts "Downloading: #{iconpath}"
				file << open("#{basenormalurl}#{iconpath}").read
			end
		return localimgpath;
	rescue Exception=>e
		puts "Download img Error:#{e}"
		return "heroiconimg/default_icon.png";
	end


end



puts "================================================================="
puts "					DOTA WIKI SPIDER"
puts "================================================================="
baseurl = 'http://www.dota2wiki.com/wiki/Special:Export/'
imageurl = 'http://www.dota2wiki.com/wiki/File:'


heroesurl = baseurl+"Heroes"
puts "Contacting Wiki server for hero list"
source = open(heroesurl){|f|f.read} #Get the export

puts "Got Hero List"


if File.directory? "images"
	puts "images Dir exists"
else
	puts "images Dir created"
	Dir.mkdir("images")
end

if File.directory? "images/heroimg"
	puts "heroimg Dir exists"
else
	Dir.mkdir("images/heroimg")
	puts "heroimg Dir created"
end

if File.directory? "images/skillimg"
	puts "skillimg Dir exists"
else
	puts "skillimg Dir created"
	Dir.mkdir("images/skillimg")
end

if File.directory? "images/heroiconimg"
	puts "heroiconimg Dir exists"
else
	puts "heroiconimg Dir created"
	Dir.mkdir("images/heroiconimg")
end


#Pattern matchers
getname = /link = (.*?)\{/
	getherojson = /<text.*?>(.*?)<\/text>/m
	getheroinfobox = /infobox(.*?)\s\=\=/im
	getherobiobox = /Hero bio(.*?)\..\}\}/m
	getyheroskillboxjson = /Skillbox(.*?)\}\}/m
	getkvps = /\|\s((.*?)\s=\s(.*?))\s/im
	getkvptwo = /(\|\s((.*?)\s=\s(.*?))\n)| ((lore)\s\=\s(.*))\.$/m
	getkvpthree = /\|\s((.*?)\s?=\s?(.*?))\n/m
	

	source.gsub(/\r\n?/, "").scan(getname){|name| 
		#puts source
		h = Hero.new
		h['name'] = name 

			heroArray.push h #Put new hero into array

			herourl = baseurl+name.first.gsub(/\s+/, "_")
			puts "------------------#{name}--------------------"
			heroSource = open(herourl){|f|f.read}#Getting Hero page
#puts heroSource
			#INFOBOX KVP's

			h['icon'] = get_hero_icon(h);

			puts "		>Geting Hero meta data"
			heroSource.scan(getheroinfobox){|infodata|
				infodata.each do |heroinfobox|

					#puts infodata
					heroinfobox.scan(getkvps){ |kvp|


# title = Earthshaker
# image = Earthshaker.png
# team = Radiant
# main = strength
# strength = 22
# strength growth = 2.5
# agility = 12
# agility growth = 1.4
# intelligence = 16
# intelligence growth = 1.8
# damage min = 46
# damage max = 56
# armor = 2.68
# move speed = 300
# attack range = 128
# attack point = 0.467
# attack backswing = 0.863
# cast point = 0.69
# cast backswing = 0.5
# attack speed = 1.7
# sight range day = 1800
# sight range night = 800

h[kvp[1]] = kvp[2]

if kvp[1].start_with?('image')
	heroimagpage = "#{imageurl}#{kvp[2].strip}"
	cleanedname = name.first.strip.gsub(/\s+/,"_")
	h['image'] = [get_image_at_page(heroimagpage,"heroimg","#{cleanedname}.png")]
end

#puts kvp[0]

}

#check for hero image


end 
}


if h['image'].length == 0 || (h['image'].length != 0 && !h['image'].first.downcase.match(/png$/))

	potentialimgnamearray = h['name'] + h['title']
	puts "Inital Export failed to Capture Image, Trying with: #{potentialimgnamearray}"
	h['image'] = [try_get_image_with_names(potentialimgnamearray,"heroimg","#{h['name']}.png")]


# 	begin
# 		open("heroimg/#{cleanedname}", 'wb') do |file|
# 			file << open(heroimagurl).read
# 		end
# 	rescue Exception=>e
# 		puts "Error:#{e}"
# 		puts "title: #{h['title']}"
# 		cleanedtitle = h['title'].first.strip.gsub(/\s+/,"_")
# 		heroimagurl = "#{imageurl}#{cleanedtitle}.png"
# 		puts "Attempting: #{heroimagurl}"
# 		begin
# 		open("heroimg/#{cleanedname}", 'wb') do |file|
# 			file << open(heroimagurl).read
# 		end
# 		rescue Exception=>e
# 		puts "Error:#{e}"
# 		end
# 		#heroimagurl = "#{imageurl}#{h['name'].first.strip.gsub(/\s+/,"_")}"
# 		#puts "Attempting: #{heroimagurl}"

# 		#begin
# 		#open("heroimg/#{h['name'].first.strip.gsub(/\s+/,"_")}", 'wb') do |file|
# 			#file << open(heroimagurl).read
# 		#end
# 		#rescue Exception=>e
# 			#puts "Error:#{e}"
# 		#end
# 	end
end


			#BIO
			puts "		>Geting Hero Bio Data"
			#puts heroSource
			heroSource.scan(getherobiobox){|biodata|
				#puts biodata
				biodata.each do |herobiodata|
					herobiodata.scan(getkvptwo){ |kvp|

# name = Raigor Stonehoof
# title = Earthshaker
# quote = Stronger by an order of magnitude!
# role = {{role|Ganker}} / {{role|Initiation}}


#puts kvp[1]
h[kvp[2]] = kvp[3]
}
end
}

			#BIO
			puts "		>Geting Hero Skills Data"
			#puts heroSource
			skillIndex = 0
			lastKeyName = ""
			heroSource.scan(getyheroskillboxjson){|skilldata|
				#puts skilldata
				s = Skill.new
				skillIndex+=1

				skilldata.each do |heroskilldata|
					heroskilldata.scan(getkvpthree){ |kvpSkills|
#puts "--->"
#puts kvp[0]
#puts ">"
#puts kvp[1]
#puts ">"
#puts kvp[2]


#Correcting Distributed Key values
if kvpSkills[1].start_with?('trait')
	lastKeyName = kvpSkills[2]
	s[kvpSkills[2]] #creating placholder for trait name
elsif kvpSkills[1].start_with?('value')
	s[lastKeyName] = kvpSkills[2].gsub(/\n/, ""); #accessing trait placholder and setting value
	lastKeyName = ""
else

	if kvpSkills[1].start_with?('image')
		cleanedskillname = "#{kvpSkills[2].strip.gsub(/\s+/,"_")}"
		skillimagpage = "#{imageurl}#{cleanedskillname}_icon.png"
		puts "Attempting: #{skillimagpage}"
		get_image_at_page(skillimagpage,"skillimg","#{cleanedskillname}.png")
	end

	s[kvpSkills[1]] = kvpSkills[2] #Normal KVP behaviour
end

}


#puts ">#{s['name']}"







h["skill"+skillIndex.to_s()]= s
#puts s.inspect
#puts "========"

end
}

#(\|\s((.*?)\s=\s(.*?))\n)| ((lore)\s\=\s(.*))\.$



			#INFOBOX
			#infobox = heroSource.scan(getheroinfoboxjson)

			#puts infobox
			#biojson = jsondata.scan(getherobiojson);
			#skilljson = jsondata.scan(getyheroskillboxjson);
		}

		puts "Writing HERO LIST to heroData.json"



		File.open("heroData.json", 'w') {|f| f.write(heroArray.to_json()) }

 # heroArray.each do |h|
 # 	# puts h.to_json()
 # 	puts "#{h.to_json()},"
 # 	#{name}
 # # 	keyArray = h.getKeys()
 # # 	puts "== #{h['title']} =="
 # # 	keyArray.each do |key|
 # # 		if key == nil
 # # 			next
 # # 		end
 # # 		val = h[key]
 # # 		if key.start_with?("skill")
 # # 			puts "==> #{key} (#{val.class})"
 # # 			skillKeyArray = val[0].getKeys()
 # # 			skillKeyArray.each do |skillkey|
 # # 				skillVal = val[0][skillkey]
 # # 				puts "#{skillkey} = #{skillVal}"
 # # 			end
 # # 		else
 # # 			puts "#{key} = #{val}"
 # # 		end
 # 	end




	# h.inspect.each do |obj|
	# 	obj
	# 	if attr_name.start_with?('skill')
	# 		puts "SKILLLLLLLLL"
	# 		attr_value.each do |skillattr_name, skillattr_value|
	
	# 			#puts "#{skillattr_name} = #{skillattr_value}"
	# 		end
	# 	else
	# 		puts "Norm Attrib"
	# 		#puts "#{attr_name} = #{attr_value}"
	# 	end
	
	# end

 # 	puts "============================"
 #end

