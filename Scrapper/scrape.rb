#!/usr/bin/ruby

require 'rubygems'
require "bundler/setup"

require 'mechanize'


#Class

# class Hero
# 	def initialize()
# 		@data = Hash.new('unknown')
# 	end
# 	def [](key)
# 		@data[key]
# 	end
# 	def []=(key,words)
# 		#@data[key] += [words].flatten
# 		@data[key].uniq!
# 	end
# 	def getKeys
# 		return @data.keys
# 	end
# 	def to_json(*a)
# 		@data.to_json(*a)
# 	end
# end


# class Ability
# 	def initialize()
# 		@data = Hash.new { |hash, key| hash[key] = "" }
# 	end
# 	def [](key)
# 		@data[key]
# 	end
# 	def []=(key,words)
# 		#@data[key] += [words].flatten
# 		@data[key].uniq!
# 	end
# 	def getKeys
# 		return @data.keys
# 	end
# 	def to_json(*a)
# 		@data.to_json(*a)
# 	end
# end


#FUNTIONS

def arrayToString(a)
	return a.map { |i| "'" + i.to_s + "'" }.join(",")
end

def printHeroDetail(hero)
	puts "--------#{hero['name']}--------"
	keyArray = hero.keys
	keyArray.each do |key|
		val = hero[key]

		if key == 'abilities'
			#Print Abilites
			printAbilities(val)
		else
			#Print Hero info

			#Array formatting
			if val.kind_of?(Array)
				processedVal = arrayToString(val)
			else
				processedVal = val
			end
			#Print..
			#puts "#{key}(#{val.class}) = #{processedVal}"
			puts "#{key} = #{processedVal}"
		end
	end
end

def printAbilities(abilities)
	abilities.each do |ability|
		printAbilityDetail(ability)
	end
end


def printAbilityDetail(ability)
	puts "Ability-->#{ability['name']}"
	keyArray = ability.keys
	keyArray.each do |key|
		val = ability[key]

		#Array formatting
		if val.kind_of?(Array)
			processedVal = arrayToString(val)
		else
			processedVal = val
		end

		#Print..
		#puts "#{key}(#{val.class}) = #{processedVal}"
		puts ">#{key} = #{processedVal}"
	end
end


def formatRoleString(roleString)
	#Spliting the roles from role string, eg. ' - Disabler - Initiator - Carry - Support'
	roleArray = roleString.split(/- /)
	#whitespace tidy..
	rolesArrayWithRemovedWhiteSpace = roleArray.collect{|role| role.strip}
	#empty string tidy..
	return rolesArrayWithRemovedWhiteSpace.reject!(&:empty?)
end

def formatBioString(bioString)
	return bioString.strip
end


#TODO: THIS FUCKING MESS
def cleanDynamicAbilityArray(a)
	stupidConcatsRegex = /%([A-Z])|\d([A-Z])/
	colonRegex = /:/

	cleanKVPs = Array.new
	splitAbilityKVPs = Array.new
	cleanedKVPs = Array.new

	a.each do |item|

		if(message.scan(colonRegex).size == 0)	
			#No concat issue present
			cleanArray.push item
		else

			positionsOfConcats = item.enum_for(:scan,stupidConcatsRegex).map { Regexp.last_match.begin(0) }
			
			if positionsOfConcats.size == 0
				puts "Error: colon assumption broke the ability Concat Regex fix"
			else
				
				positionsOfConcats.each do |concatedIndex|
					splitAttempt = item[(concatedIndex-1)..concatedIndex]
					splitAbilityKVPs.push splitAttempt
				end
			end
		end
	end

	return cleanKVPs | splitAbilityKVPs
end


#Agent init and config
agent = Mechanize.new

agent.user_agent = 'Individueller User-Agent'
agent.user_agent_alias = 'Linux Mozilla'

heroArray = Array.new

puts "================================================================="
puts "					DOTA2 SPIDER"
puts "================================================================="

heroListPage = agent.get('http://www.dota2.com/heroes/')

#Getting the list of url's for each Hero found at http://www.dota2.com/heroes/
heroListPage.links_with(:dom_class => "heroPickerIconLink").each do |link|
	#Create Hero Object
	h = Hash.new
	#add URL KVP
	h['url'] = link.uri
	#Add Hero to hero array
	heroArray.push h
end

#For Each Hero is list, go to URL and Scrap it..
heroArray.each do |h|

 	#Get Hero page at http://www.dota2.com/hero/<HERO NAME>/
 	heroDetailPage = agent.get h['url']

 	#Get Hero details
 	h['portraitUrl'] = heroDetailPage.image_with(:dom_id => "heroTopPortraitIMG")
 	h['name'] = heroDetailPage.at('//*[@id="centerColContent"]/h1/text()')
 	h['attackMode'] = heroDetailPage.at('//*[@id="heroBioRoles"]/span/text()')
 	h['roles'] = formatRoleString(heroDetailPage.at('//*[@id="heroBioRoles"]/text()').content)
 	h['bio'] = formatBioString(heroDetailPage.at('//*[@id="bioInner"]/text()').content)
 	h['intVal'] = heroDetailPage.at('//*[@id="overview_IntVal"]/text()')
 	h['strVal'] = heroDetailPage.at('//*[@id="overview_StrVal"]/text()')
 	h['agiVal'] = heroDetailPage.at('//*[@id="overview_AgiVal"]/text()')
 	h['attackVal'] = heroDetailPage.at('//*[@id="overview_AttackVal"]/text()')
 	h['speedVal'] = heroDetailPage.at('//*[@id="overview_SpeedVal"]/text()')
 	h['defenceVal'] = heroDetailPage.at('//*[@id="overview_DefenseVal"]/text()')

 	#Get Hero Stats
 	h['hp'] = heroDetailPage.at('//*[@id="statsLeft"]/div[2]/div[3]/text()')
 	h['sight'] = heroDetailPage.at('//*[@id="statsRight"]/div[2]/div/text()')
	h['range'] = heroDetailPage.at('//*[@id="statsRight"]/div[3]/div/text()')
	h['missileSpeed'] = heroDetailPage.at('//*[@id="statsRight"]/div[4]/div/text()')

	heroAbilities = Array.new

	#Get Ability Element array
	heroAbilitiesElements = heroDetailPage.search('.abilitiesInsetBoxContent')
	
	#For each ability node...
	heroAbilitiesElements.each do |node|
		if node.kind_of?(Nokogiri::XML::Element)

			#Create Ability Object
			a = Hash.new

	 		#Get consistant ability details
	 		a['imgUrl'] = node.at('div[1]/div[1]/img')['src']
	 		a['name'] = node.at('div[1]/div[2]/h2/text()')
	 		a['description'] = node.at('div[1]/div[2]/p/text()')
	 		a['lore'] = node.at('div[4]/text()')

			#Get Dynamic ability cols...this bits a bit of a mess..blame Valve
			# heroAbilityKeyValueElement = node.search('.abilityFooterBox')[0]
			# heroAbilityKeyValueArray = cleanDynamicAbilityArray(heroAbilityKeyValueElement.text.split( /\r?\n/ ).collect{|item| item.strip}.reject!(&:empty?))

			# #DEBUG...
			# heroAbilityKeyValueArray.each do |abiltyKVP|
			# 	puts ">'#{abiltyKVP}'"
			# end

			#puts "=========>#{heroAbilityKeyValueElement.class} [#{heroAbilityKeyValueElement}]"
			# a['target'] = node.at('div[2]/div[1]/span[1]/text()')
			# a['affects'] = node.at('div[2]/div[1]/span[2]/text()')
			# a['damageType'] = node.at('div[2]/div[1]/span[3]/text()')
			# a['damage'] = node.at('div[2]/div[2]/span[1]/text()')
			# a['damage'] = node.at('div[2]/div[2]/span[1]/text()')
			# a['damage'] = node.at('div[2]/div[2]/span[1]/text()')

			#Get optional ability details
			manaElement = node.at('div[1]/div[3]/div/div[1]/text()')
			if manaElement
				a['manaVal'] = manaElement
			end

			coolDownElement = node.at('div[1]/div[3]/div/div[2]/text()')
			if coolDownElement
				a['cooldownVal'] = coolDownElement
			end

			iframeElement = node.at('div[3]/iframe')
			if iframeElement
				a['videoUrl'] = iframeElement['src']
			end	

			#add ability to ability array
			heroAbilities.push a
		end
	end

	#add ability array to hero
	h['abilities'] = heroAbilities

	#Debug: Print Hero detail to console
	printHeroDetail(h)
end

#TODO: HASH TO JSON CONVERSION
#Write Hero list to JSON
#File.open("heroData.json", 'w') {|f| f.write(heroArray.to_json()) }








































