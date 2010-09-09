require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'part2'

CNN_RSS = 'http://rss.cnn.com/rss/cnn_topstories.rss'

def get_breaking_news(min)
  doc = Hpricot(open(CNN_RSS))
  items = doc.search('item')
  recent_items = items.find_all do |item|
    pubdate = item.search('pubdate')
    if pubdate
      (Time.now - Time.parse(pubdate.inner_html)) < (60 * min)
    else
      false
    end
  end
  recent_items.map do |item|
    pubdate = item.search('pubdate').inner_html
    title = item.search('title').inner_html
    guid = item.search('guid').inner_html
    NewStory.new(title, guid, Time.parse(pubdate))
  end
end


