require 'open-uri'
require 'hpricot'

class Movie < ActiveRecord::Base

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_length_of :description, :minimum => 10
  validates_inclusion_of :rating, :in => ['G', 'PG', 'PG-13', 'R', 'NC-17']

  SEARCH_URL_BASE = 'http://api.themoviedb.org/2.1/Movie.search/en/xml/12204fc3fcae6869ad566b612d01c8d3/'
  GETINFO_URL_BASE = 'http://api.themoviedb.org/2.1/Movie.getInfo/en/xml/12204fc3fcae6869ad566b612d01c8d3/'

  def appropriate_for_brithdate?(birthdate)
    if self.rating == 'G' || self.rating == 'PG'
      true
    elsif self.rating == 'PG-13'
      13.years.ago > birthdate
    elsif self.rating == 'NC17' || self.rating == 'R'
      17.years.ago > birthdate
    else
      false
    end
  end

  def self.find_all_appropriate_for_birthdate(birthdate)
    if birthdate < 17.years.ago
      self.find :all
    elsif birthdate < 13.years.ago
      self.find :all, :conditions => {:rating => ['G', 'PG', 'PG-13']}
    else
      self.find :all, :conditions => {:rating => ['G', 'PG']}
    end
  end

  def self.search(query)
    doc = self.getDocFromUrl(SEARCH_URL_BASE + query)
    movies = self.getNumMoviesFromDoc(5, doc)
  end

  def self.search_by_id(id)
    doc = self.getDocFromUrl(GETINFO_URL_BASE + id.to_s)
    movies = self.getNumMoviesFromDoc(1, doc)
    movies[0]
  end

  private

  def self.getDocFromUrl(url)
    begin
      doc = Hpricot(open(url))
    rescue
      doc = nil
    end
  end

  def self.getNumMoviesFromDoc(num, doc)
    movies = []
    if doc != nil
      movieDOMs = doc.search('movie')
      movieDOMs.each do |movieDOM|
        if num <= 0
          break
        end
        num -= 1
        movies << self.getMovieFromMovieDOM(movieDOM)
      end
    end
    return movies
  end

  def self.getMovieFromMovieDOM(movieDOM)
    movie = Movie.new
    movie.id = movieDOM.at('id').inner_html
    movie.title = movieDOM.at('name').inner_html
    movie.rating = movieDOM.at('rating').inner_html
    movie.description = movieDOM.at('overview').inner_html
    movie.released_on = Time.parse(movieDOM.at('released').inner_html)
    return movie
  end

end
