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

   it "should be appropriate for a 15-year-old if rated G"

   it "should be appropriate for a 30-year-old if rated G"

   it "should not be appropriate for a 15-year-old if rated R"

 end


 describe "database finder for age-appropriateness" do

   it "should always include G rated movies" do

     @movie = Movie.create!(@valid_attributes)

     Movie.find_all_appropriate_for_birthdate(Time.now).should include(@movie)

   end

   it "should exclude R rated movies if age is less than 17"


 end

end

