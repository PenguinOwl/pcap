require "yt"
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
      puts "s"
      begin
      vid.comment_threads.each do |thread|
        if thread.can_reply? then
        puts "a"
        $chars = $chars + " " + thread.text_display
        end
      end
      rescue Yt::Errors::Forbidden
      end
    end
    return $chars
  end
end

puts YTinteract.new.get
