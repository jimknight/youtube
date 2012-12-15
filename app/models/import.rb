class Import < ActiveRecord::Base

  attr_accessible :status, :url

  def self.grab_youtube_video(youtube_video_url)

require "open3"
Open3.popen3("youtube-dl #{youtube_video_url} -o '/Users/jimknight/Videos/youtube/%(title)s'") do |stdin, stdout, stderr|
    puts "stderr - #{stderr.read}"
    puts "stdout - #{stdout.read}"
end

  end

end
