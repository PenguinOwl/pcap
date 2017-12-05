a = 0
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
scan("hi i am a cool dudes",[Pattern.new("dude")])
