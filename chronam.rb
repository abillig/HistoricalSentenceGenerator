require 'rubygems'
require 'nokogiri' 
require 'open-uri'

puts "enter a word"
term=gets.chomp
puts "enter a year"
year=gets.chomp

puts "searching through heaps of digitized newspapers for "+term+"..."

states = "Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts 
Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada New+Hampshire New+Jersey New+Mexico New+York North+Carolina North+Dakota Ohio Oklahoma Oregon Pennsylvania South+Carolina South+Dakota Tennessee Texas Utah Vermont Virginia Washington 
West+Virginia Wisconsin Wyoming"

statesarray = states.split(" ")

#resultshash stores the sentences that the program has found

resultshash={}

#move down a randomly shuffled list of states, completing the search for each state, until
#four sentences have been selected. By shuffling, if the user enters the same search results
#another time once the program has been run, they'll likely get a different set of 
#sentences. 

statesarray.shuffle.each do |state|
  if resultshash.keys.length < 5

#pull up the search page with 300 results
full_link = 'http://chroniclingamerica.loc.gov/search/pages/results/?state='+state+'&dateFilterType=range&date1='+year+'&date2='+year+'&sequence=1&language=&ortext=&andtext=&phrasetext=&proxtext='+term+'&proxdistance=5&rows=300&searchType=advanced'


#opens the link to the page and then saves each linked newspaper copy in the news_link array
page = Nokogiri::HTML(open(full_link))
news_links = page.css('div#container div#content div#main_body div table.search_results a')

#gets the full url for each newspaper copy in search results, puts them in urls

urls=[]
puts urls

news_links.each{|link| urls << "http://chroniclingamerica.loc.gov#{link['href']}"}


#gets a random newspaper copy, stores it in 'sample'

sample= urls.sample

#a method that returns the periodical, date, and url for a sentence
def citation(url)
  sections=url.split("/")
  datesections = sections[5].split("-")
  puts "#{datesections[1]}/#{datesections[2]}/#{datesections[0]}"

#gets url up to and including date for precise url citation
citationurl=[]

y=0
while y < 8
  citationurl<<sections[y]
  y+=1
end

#gets url up to date for transition to json info
jsonurl=[]
  x=0

  while x < 5
    jsonurl << sections[x]
    x+=1
  end

the_json_url=jsonurl.join("/")+".json"
  page = Nokogiri::HTML(open(the_json_url))
maintext = page.css('body p')
maintextarray=[]
maintext.each do |whateveritis|
  maintextarray<<whateveritis
end
jsonstring=maintextarray.join("")
splitjson = jsonstring.split("{")
keyvaluepairs = splitjson[1].split(",")
pairshash=Hash.new(0)
keyvaluepairs.each do |pair|
  keyvalue=pair.split(":")
  pairshash[keyvalue[0]] = keyvalue[1]
end
puts "#{pairshash[" \n  \"name\""]}
(#{citationurl.join("/")})"

end



#a method that turns the sample url, which shows a newspaper page,
# into the ocrd version of that page

def become_ocr(url)
  segments = url.split("/")
  stub=[]
  segments.each do |segment|
    if segment != "seq-1"
stub << segment
stub<<"/"
elsif segment == "seq-1"
  stub << segment
  stub<<"/"
  break
end
end
shortened = stub.join("")
return shortened+"ocr/"
end

#this takes care of search results which don't turn up anything. basically, 
#if there are any urls at all to consider, turn them into ocr and complete process. 
#otherwise, move on to the next search term + state pair 

if urls.length > 0 


#finds a sentence in the ocrd search results that contains the search term. 
#does this by searching the 'p' elements in each randomly sampled newspaper copy.
#if one of the p elements contains the word searched for, it'll return the sentence. 
#otherwise, it'll move on to the next search result

samples=0
stoptheloop=0
until stoptheloop!=0


  ocrd=become_ocr(urls.sample)



page = Nokogiri::HTML(open(ocrd))
textelements = page.css('p')

textelementsarray=[]

textelements.each do |element|
  textelementsarray << element
end

joinedelements = textelementsarray.join("")

sentences = joinedelements.split(".")

wordsarray=[]

sentences.each do |sentence|
  words = sentence.split(" ")
  words.each do |word|
    if word == term
      wordsarray<<sentence
    end
  end
end

if wordsarray.length != 0
  stoptheloop +=1
end

#displays search results as soon as they're discovered

resultshash[state]=wordsarray[0]
if wordsarray.length!=0
puts "#{state}: #{wordsarray[0]}"
puts citation(ocrd)
end

#this conditional lets the program look through each search result once and if it doesn't find 
#anything, to break the loop so it doesn't keep looping through the same results over and over

if samples < urls.length
samples +=1
else
  break
end


end
else 
end
else 
  break
end
end

