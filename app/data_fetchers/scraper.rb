require 'pry'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'rest-client'
require 'rubygems'

require_relative '../models/game.rb'

class Scraper

	def initialize 
		@game_object_list = []
		@game_list = []
		@genre_list = {}
		@genre_type = []
	end

	def genre_type
		@genre_type
	end

	def game_list
		i = 0
		while i <= 31
			i += 1
			@games = Nokogiri::HTML(open('http://www.gamespot.com/new-games/?sort=alpha&game_filter_type%5Bplatform%5D=120&game_filter_type%5Bgenres%5D=&game_filter_type%5BminRating%5D=&game_filter_type%5BtimeFrame%5D=&game_filter_type%5BstartDate%5D=&game_filter_type%5BendDate%5D=&game_filter_type%5Btheme%5D=&game_filter_type%5Bregion%5D=1&___game_filter_type%5Bdevelopers%5D=&___game_filter_type%5Bpublishers%5D=&game_filter_type%5Bletter%5D=' + "&page=" + "#{i}"))
			@game_list << @games.css("h3.media-title").children.collect { |o| o.text}
		end	
		@game_list.flatten!.each {|name| @game_object_list << Game.new(name)}
	end

	def genre_list
		i = 0
		while i <= 66
			i += 1
			@genres = Nokogiri::HTML(open('http://www.gamespot.com/new-games/?sort=alpha&game_filter_type%5Bplatform%5D=120&game_filter_type%5Bgenres%5D=' + "#{i}" + "&game_filter_type%5BminRating%5D=&game_filter_type%5BtimeFrame%5D=&game_filter_type%5BstartDate%5D=&game_filter_type%5BendDate%5D=&game_filter_type%5Btheme%5D=&game_filter_type%5Bregion%5D=1&___game_filter_type%5Bdevelopers%5D=&___game_filter_type%5Bpublishers%5D=&game_filter_type%5Bletter%5D="))
			@genre_list[@games.css("select[id='game_filter_type_genres']").css("option[value='" + "#{i}" + "']").text.to_sym] ||= @genres.css("h3.media-title").children.collect { |o| o.text} 
		end
		@game_object_list.each do |game|
			@genre_list.each do |genre_type, genre_games|
				game.genre << "#{genre_type.to_s.capitalize}" if genre_games.include? game.name
				@genre_type << genre_type
			end
		end
		@game_object_list.each { |g| g.genre = "N/A" if g.genre == [] }
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
new_pro.game_list
new_pro.genre_list