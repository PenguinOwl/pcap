require "yt"
$log = File.new("log_" + Time.now.to_s + ".txt", "w+")
class Pattern
  attr_accessor :list, :first, :full
  def initialize(text)
    if text != nil and text != ""
    text.downcase!
    @first = text[0]
    @full = text
    @list = text.split("")
    @list.delete_at(0)
    end
  end
end
def createPatterns(filename)
  file = File.open(filename, "r+")
  words = file.read.split("\n")
  ptrlist = []
  words.each { |word|
    if word != nil and word != ""
      ptrlist << Pattern.new(word)
    end
  }
  return ptrlist
end
print "File to template? "
$ms = createPatterns(gets.strip)
class YTinteract
  def get
    print "API Key: " 
    Yt.configure do |config|
        config.api_key = gets.strip
        config.log_level = :debug
    end
    $chars = ""
    print "Channel ID: "
    channel = Yt::Channel.new id: gets.strip
    channel.videos.each do |vid|
      begin
      vid.comment_threads.each do |thread|
        if thread.can_reply? then
        scan(thread.text_display, $ms)
        end
      end
      rescue Yt::Errors::Forbidden
      end
    end
    return $chars
  end
end
a = 0
def scan(text, ptrlist)
  words = text.split(" ")
  words.each_index { |i|
    a = 0
    n = 0
    x = words[i]
    unless x == nil or x == "" or x.include? ">" or x.include? "<" then
    ptrlist.each { |pattern|
      if pattern.first == Pattern.new(words[i]).first and ((Pattern.new(words[i]).list - pattern.list) | (pattern.list - Pattern.new(words[i]).list)).size < (pattern.list.size / 2) then 
        n = (pattern.list - Pattern.new(words[i]).list)
        words.delete_at(i)
        a = 1
      end
      }
    $log.write(x+" -  "+a.to_s+" $"+n.to_s+"\n")
      end
  }
  puts words.join(" ")
  
end
YTinteract.new.get
$log.close
