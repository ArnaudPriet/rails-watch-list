# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

Bookmark.destroy_all

base_url = "/movie/top_rated?"
url = "http://tmdb.lewagon.com#{base_url}"
movie_serialized = URI.open(url).read
movie = JSON.parse(movie_serialized)
Movie.destroy_all
movie["results"].each do |m|
    Movie.create!(
        title: m['title'],
        overview: m['overview'],
        poster_url: "https://image.tmdb.org/t/p/w500#{m['poster_path']}",
        rating: m['vote_average']
    )
end
count = Movie.count
p "#{count} movies have been created"
List.create(name: "Horror")
List.create(name: "Science fiction")
List.create(name: "Comedy")
List.create(name: "Aventure")
List.create(name: "Action")
