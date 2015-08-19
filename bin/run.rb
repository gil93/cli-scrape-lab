require_relative '../config/environment'

# something = GameCLI.new
# something.genrelist

new_scrape = Scraper.new
new_scrape.game_list
new_scrape.genre_list

# new_cli = GameCLI.new
# new_cli.genre_selection(new_scrape.genre_type)
# new_cli.run(new_scrape.genre_type)
# new_cli.games_by_genre(new_scrape.game_object_list)