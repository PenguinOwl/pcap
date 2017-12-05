class Pattern
  attr_accessor :list, :first, :full
  def initalize(text)
    text.downcase!
    @first = text[0]
    @full = text
    @list = text.split("")
    @list.delete_at(0)
  end
end
def scan(text, ptrlist)
  file = File.new("log_" + Time.now.to_s + ".txt", "w+")
  words = text.split(" ")
  words.each_index { |i|
    a = 0
    ptrlist.each { |pattern|
      if pattern.first == Pattern.new(words[i]).first and (pattern.list - Pattern.new(words[i]).list)) < (Pattern.new(words[i]).list.size / 2) then 
        words.delete_at(i)
        a = 1
      end
    }
    file.write(words[i]+" "+a.to_s+"\n")
  }
  puts words.join(" ")
  file.close
end
scan("hi i am a cool dudes",[Pattern.new("dude")])
