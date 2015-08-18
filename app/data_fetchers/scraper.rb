require 'pry'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'rest-client'
require 'rubygems'
class Scraper

	def initialize 
		@game_list = []
		@object_list = []
		@genre = []
		@genre_list = []
	end

	def game_list
		i = 0
		while i <= 31
			i += 1
			@game = Nokogiri::HTML(open('http://www.gamespot.com/new-games/?sort=alpha&game_filter_type%5Bplatform%5D=120&game_filter_type%5Bgenres%5D=&game_filter_type%5BminRating%5D=&game_filter_type%5BtimeFrame%5D=&game_filter_type%5BstartDate%5D=&game_filter_type%5BendDate%5D=&game_filter_type%5Btheme%5D=&game_filter_type%5Bregion%5D=1&___game_filter_type%5Bdevelopers%5D=&___game_filter_type%5Bpublishers%5D=&game_filter_type%5Bletter%5D=' + "&page=" + "#{i}"))
			@game_list << @game.css("h3.media-title").children.collect { |o| o.text}
		end	
		@game_list.flatten!
	end

	def object_list
		@game_list.each {|name| @object_list << Game.new(name)}
	end

	def genre_list
		i = 0
		while i <= 31
			i += 1
			case i
			when 5
				@genre = Nokogiri::HTML(open('http://www.gamespot.com/new-games/?sort=alpha&game_filter_type%5Bplatform%5D=120&game_filter_type%5Bgenres%5D='+"#{i}"+"&game_filter_type%5BminRating%5D=&game_filter_type%5BtimeFrame%5D=&game_filter_type%5BstartDate%5D=&game_filter_type%5BendDate%5D=&game_filter_type%5Btheme%5D=&game_filter_type%5Bregion%5D=1&___game_filter_type%5Bdevelopers%5D=&___game_filter_type%5Bpublishers%5D=&game_filter_type%5Bletter%5D="))
				@genre_list << @genre.css("h3.media-title").children.collect { |o| o.text}
			end
		end
		binding.pry
	end
	
end

	# @objectlist = []
	# @list.each do |name|
	# 	@objectlist << Gameobject.new(name)
	# end

	# @objectlist.each do |gameobject|
	# 	gameobject.genre = "horror" if @horror.include? gameobject.name
	# end

new_pro = Scraper.new
binding.pry
new_pro.genre_list