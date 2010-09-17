class Movie < ActiveRecord::Base

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_length_of :description, :minimum => 10
  validates_inclusion_of :rating, :in => ['G', 'PG', 'PG-13', 'R', 'NC-17']

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
end
