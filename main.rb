require "yt"
class Pattern
  attr_accessor :list, :first, :full
  def initialize(text)
    text.downcase!
    @first = text[0]
    @full = text
    @list = text.split("")
    @list.delete_at(0)
  end
end
def createPatterns(filename)
  file = File.open(filename,"r+")
  words = file.read.split("\n")
  ptrlist = []
  words.each { |word|
    ptrlist << Pattern.new(word)
  }
  return ptrlist
end
print "File to template? "
ms = createPatterns(gets.strip)
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
        scan(thread.text_display, ms)
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
  file = File.new("log_" + Time.now.to_s + ".txt", "w+")
  words = text.split(" ")
  words.each_index { |i|
    a = 0
    n = 0
    x = words[i]
    ptrlist.each { |pattern|
      if pattern.first == Pattern.new(words[i]).first and (pattern.list - Pattern.new(words[i]).list).size < (Pattern.new(words[i]).list.size / 2) then 
        n = (pattern.list - Pattern.new(words[i]).list)
        words.delete_at(i)
        a = 1
      end
    }
    file.write(x+" -  "+a.to_s+" $"+n.to_s+"\n")
  }
  puts words.join(" ")
  file.close
end
YTinteract.new.get
