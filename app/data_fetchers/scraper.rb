class Scraper

	def initialize 
		@list = []
	end

	def game_list
		i = 0
		while i <= 31
			i += 1
			@html = Nokogiri::HTML(open('http://www.gamespot.com/new-games/?sort=alpha&game_filter_type%5Bplatform%5D=120&game_filter_type%5Bgenres%5D=&game_filter_type%5BminRating%5D=&game_filter_type%5BtimeFrame%5D=&game_filter_type%5BstartDate%5D=&game_filter_type%5BendDate%5D=&game_filter_type%5Btheme%5D=&game_filter_type%5Bregion%5D=1&___game_filter_type%5Bdevelopers%5D=&___game_filter_type%5Bpublishers%5D=&game_filter_type%5Bletter%5D=' + "&page=" + "#{i}"))
			@list << @html.css("h3.media-title").children.collect { |o| o.text}
		end	
		@list.flatten!
	end

	def genre_list

	end
end

	# @objectlist = []
	# @list.each do |name|
	# 	@objectlist << Gameobject.new(name)
	# end

	# @objectlist.each do |gameobject|
	# 	gameobject.genre = "horror" if @horror.include? gameobject.name
	# end