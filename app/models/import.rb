class Import < ActiveRecord::Base

  attr_accessible :status, :url

  def self.get_latest_pending_urls(pending_imports_url)
    pending_urls_found = []
    if !pending_imports_url.include?("http")
      pending_imports_url = "http://#{pending_imports_url}"
    end
    page = Nokogiri::HTML(RestClient.get(pending_imports_url))
    list_items = page.css('li')
    list_items.each do |list_item|
      pending_urls_found << list_item.text
    end
    return pending_urls_found
  end

  def self.grab_youtube_video(youtube_video_url)
    require "open3"
    Open3.popen3("youtube-dl #{youtube_video_url} -o '/Users/jimknight/Videos/youtube/%(title)s.flv'") do |stdin, stdout, stderr|
        puts "stderr - #{stderr.read}"
        puts "stdout - #{stdout.read}"
    end
  end

  def self.convert_flv_to_mp4(flv_path)
    require "open3"
    command = "ffmpeg -i '#{flv_path}' -vcodec copy -acodec libfaac -aq 200 '#{flv_path}.mp4'"
    Open3.popen3(command) do |stdin, stdout, stderr|
        puts "stderr - #{stderr.read}"
        puts "stdout - #{stdout.read}"
    end
  end

  def self.move_mp4_to_itunes(mp4_path)
    require "open3"
    command = "mv '#{mp4_path}' '/Users/jimknight/Music/iTunes/iTunes Media/Automatically Add to iTunes'"
    Open3.popen3(command) do |stdin, stdout, stderr|
        puts "stderr - #{stderr.read}"
        puts "stdout - #{stdout.read}"
    end
  end

end
