require "yt"
class YTinteract
  def get()
    print "API Key: " 
    Yt.configure do |config|
        config.api_key = gets.strip
    end
    $chars = ""
    print "Channel ID: "
    channel = Yt::Channel.new id: gets.strip
    channel.videos.each do |vid|
      vid.comment_threads.each do |thread|
        $chars = $chars + " " + thread.text_display
      end
    end
    return $chars
  end
end
