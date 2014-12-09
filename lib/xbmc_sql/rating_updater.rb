require 'httparty'

class XbmcSql::RatingUpdater

  def self.go!
    XbmcSql::Movie.find_each { |movie| XbmcSql::RatingUpdater.new(movie).scrape! }
  end

  attr_accessor :movie

  def initialize(movie)
    @movie = movie
  end

  def scrape!
    return unless has_imdb?

    response = HTTParty.get "http://www.omdbapi.com/?i=#{movie.imdb_id}"
    if json_response = JSON.parse(response.body)
      if json_response['imdbRating'].present?
        puts "Updating #{movie.title} from #{movie.rating} to #{json_response['imdbRating']}"
        movie.update_attributes! rating: json_response['imdbRating'], rating_votes: json_response['imdbVotes']
      else
        puts "json_response = #{json_response}"
      end
    end
  rescue => e
    puts e
  end

private

  def has_imdb?
    movie.imdb_id.present?
  end
end
