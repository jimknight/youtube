require 'spec_helper'

describe Import do
  it "should pull down a youtube video given a url" do
    youtube_video_url = "http://www.youtube.com/watch?v=hUhxq4g3sVA"
    Import.grab_youtube_video(youtube_video_url)
  end
end
