#!/usr/bin/ruby

require 'rubygems'
require "bundler/setup"
require 'json'
require 'mechanize'
require 'active_support'

verbose = false

# def arrayToString(a)
# 	return a.map { |i| "'" + i.to_s + "'" }.join(",")
# end

# def printItem(item,level)
# 	#puts "#{item} (#{item.class})\n"
# 	keyArray = item.keys

# 	keyArray.each do |key|
# 		val = item[key]
# 		itemText = ">"

# 		#Level indentation
# 		for i in 0..level
#    		itemText + "  "#two spaces per level
# 		end

# 		itemText + key
# 		itemText + " - "
		
# 		if(val.is_a?(Hash))#RECURSE
# 			puts "Item: '#{itemText}'"
# 			puts "HASH FOUND! #{level}"
# 			printItem(val,level+1)#increase level by 1
# 		else
# 			itemText + val.to_s
# 			puts "Item: '#{itemText}'"
# 		end
# 	end
# end

# def printItemArray(itemArray)
# 	itemArray.each do |item|
# 		printItem(item)
# 	end
# end

#http://www.dota2.com/items/

#Agent init and config
agent = Mechanize.new

agent.user_agent = 'Individueller User-Agent'
agent.user_agent_alias = 'Linux Mozilla'


puts "================================================================="
puts "					DOTA2 ITEM SPIDER"
puts "================================================================="
puts "Getting Item JSON.."

itemJSONPage = agent.get('http://www.dota2.com/jsfeed/heropediadata?feeds=itemdata&v=4161831521684904797&l=english')
baseItemURL = "http://media.steampowered.com/apps/dota2/images/items/"
#image eg. sobi_mask_lg.png, use img prop in item JS object

#printItemArray(itemArray);
puts "Writing ITEM JSON to file.."
File.open("item.json", 'w') {|f| f.write(itemJSONPage.content) }
puts "Done"


 	






































