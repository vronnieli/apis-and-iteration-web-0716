require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  data = character_hash["results"]
  films_array = data.collect do |character_details|
    if character_details["name"].downcase == character
      character_details["films"]
    end
  end
  films_array.compact!

  films_clean_array = films_array[0]

  all_film_details_with_character = []

  films_clean_array.each do |movie_url|
    film_api = RestClient.get(movie_url)
    all_film_details_with_character << JSON.parse(film_api)
  end

  all_film_details_with_character
  # iterate ove the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

end


def parse_character_movies(films_hash)
  films_hash.each do |individual_film_hash|
    puts individual_film_hash["title"]
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end



## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
