require 'spec_helper'

describe Import do
  it "should pull down a youtube video given a url" do
    youtube_video_url = "http://www.youtube.com/watch?v=hUhxq4g3sVA"
    Import.grab_youtube_video(youtube_video_url)
  end
  it "should convert an flv into mp4" do
    Import.convert_flv_to_mp4(Rails.root.join('spec','fixtures','Retina iPads No Match for iPad Minis.flv'))
  end
  it "should put the new mp4 into the itunes directory for import" do
    Import.move_mp4_to_itunes(Rails.root.join('spec','fixtures','Retina iPads No Match for iPad Minis.flv.mp4'))
  end
end
