class Game
	def initialize name
		@name = name
		@genre = []
	end

	def name
		@name
	end

	def genre= genre
		@genre << genre
	end

	def genre
		@genre
	end
end