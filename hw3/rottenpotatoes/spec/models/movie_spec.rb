require 'spec_helper'

describe Movie do

 before(:each) do

   @valid_attributes = {

     :title => "Pocahontas",

     :description => "A movie about the new world.",

     :rating => "G",

     :released_on => Time.parse("1/1/1995")

   }

 end

 

 it "should create a new instance given valid attributes" do

   Movie.create(@valid_attributes).should be_true

 end

 

 describe "when validating a movie" do

   it "should not allow a movie with no title" do

     @no_title_attributes = {

       :description => "A movie about the new world.",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.new(@no_title_attributes)

     @movie.should_not be_valid

   end

 

   it "should not allow a movie with no description" do

     @no_description_attributes = {

       :title => "A Whole New World",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.new(@no_description_attributes)

     @movie.should_not be_valid

   end


   it "should not allow a movie with a title that is not unique" do

     Movie.create(@valid_attributes)

     Movie.new(@valid_attributes).should_not be_valid

   end

   it "should not allow a movie with a description less than 10 characters long" do

     @short_description_attributes = {

       :title => "A Whole New World",

       :description => "",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     9.times do |count|
       @short_description_attributes[:description] += "0"
       Movie.new(@short_description_attributes).should_not be_valid
     end

   end


   it "should allow a movie with a valid movie rating" do

     @valid_rating_attributes = {

       :title => "Pocahontas",

       :description => "A movie about the new world.",

       :released_on => Time.parse("1/1/1995")

     }

     ['G', 'PG', 'PG-13', 'R', 'NC-17'].each do |rating|
       @valid_rating_attributes[:rating] = rating
       Movie.new(@valid_rating_attributes).should be_valid
     end

   end

   it "should not allow a movie with an invalid movie rating" do

     @valid_rating_attributes = {

       :title => "Pocahontas",

       :description => "A movie about the new world.",

       :released_on => Time.parse("1/1/1995")

     }

     ['H', 'PK', 'PG-14', 'S', 'WC-17'].each do |rating|
       @valid_rating_attributes[:rating] = rating
       Movie.new(@valid_rating_attributes).should_not be_valid
     end

   end

 end


 # Add more specs here!




 describe "when checking age-appropriateness" do

   it "should be appropriate for a 15-year-old if rated G" do
     @g_rating_attributes = @valid_attributes.dup
     @g_rating_attributes[:rating] = 'G'

     @movie = Movie.create!(@g_rating_attributes)

     @movie.appropriate_for_brithdate?(15.years.ago).should be_true

   end


   it "should be appropriate for a 30-year-old if rated G" do

     @g_rating_attributes = @valid_attributes.dup
     @g_rating_attributes[:rating] = 'G'

     @movie = Movie.create!(@g_rating_attributes)

     @movie.appropriate_for_brithdate?(30.years.ago).should be_true

   end

   it "should not be appropriate for a 15-year-old if rated R" do

     @r_rating_attributes = @valid_attributes.dup
     @r_rating_attributes[:rating] = 'R'

     @movie = Movie.create!(@r_rating_attributes)

     @movie.appropriate_for_brithdate?(15.years.ago).should_not be_true

   end

 end


 describe "database finder for age-appropriateness" do

   it "should always include G rated movies" do

     @movie = Movie.create!(@valid_attributes)

     Movie.find_all_appropriate_for_birthdate(Time.now).should include(@movie)

   end

   it "should exclude R rated movies if age is less than 17" do

     @r_rating_attributes = @valid_attributes.dup
     @r_rating_attributes[:rating] = 'R'

     @movie = Movie.create!(@r_rating_attributes)

     Movie.find_all_appropriate_for_birthdate(16.years.ago).should_not include(@movie)

   end

 end

 describe "when searching for movie on TMDb" do

   it "should return arrays of movies with valid titles if the query is 'transformers'" do
     @movies = Movie.search "Transformers"
     @movies.each do |movie|
       movie.should be_an_instance_of Movie
       movie.title.should_not == nil
       movie.title.should_not == ''
     end
   end

   it "should return 5 movies if the the query is 'transformers'" do
     @movies = Movie.search "Transformers"
     @movies.size.should == 5
   end

   it "should return 1 movie if the the query is 'bruce almighty'" do
     @movies = Movie.search "bruce almighty"
     @movies.size.should == 1
   end

   it "should return 1 movie if the the query is 'king of the underworld'" do
     @movies = Movie.search "king of the underworld"
     @movies.size.should == 1
   end

   it "should return 0 movies if the the query is 'xjfnak'" do
     @movies = Movie.search "xjfnak"
     @movies.size.should == 0
   end

   it "should return a movie named 'Bruce Almighty' if the id is 310" do
     @movie = Movie.search_by_id 310
     @movie.should_not == nil
     @movie.title.should == 'Bruce Almighty'
   end

   it "should return a movie named 'Bruce Almighty' if the id is the string '310'" do
     @movie = Movie.search_by_id '310'
     @movie.should_not == nil
     @movie.title.should == 'Bruce Almighty'
   end

   it "should return nil if the id is 12345678" do
     @movie = Movie.search_by_id 12345678
     @movie.should == nil
   end

   it "should return nil if the input is not an int" do
     @movie = Movie.search_by_id 'Hello'
     @movie.should == nil
   end
 end

end

