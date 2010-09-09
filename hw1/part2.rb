#1
class Numeric
  def factorial
    if self > 1
      self * (self - 1).factorial
    else
      1
    end
  end
end

class NewStory
  #2
  attr_accessor :title, :guid, :pub_date

  #3
  def initialize(title, guid, pub_date)
    self.title = title
    self.guid = guid
    self.pub_date = pub_date
  end

  #4
  def to_s
    self.title + ' published on ' + self.pub_date.to_s + ' with id ' + self.guid.to_s
  end
end

#5
def string_of_all_stories(all_stories)
  all_stories.map do |s|
    s.to_s + "\n"
  end.join("")
end

class Time
  def self.tomorrow
    Time.now + 24*60*60
  end
end

