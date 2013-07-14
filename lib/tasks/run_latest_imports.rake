desc "Pull the latest of imports and then import them"
task :pull_imports => :environment do
  # go get the list of videos
  puts "get urls"
  new_import_urls = Import.get_latest_pending_urls("http://youtube.lavatech.com/imports")
  if !new_import_urls.empty?
    new_import_urls.each do |url|
      puts "grabbing #{url}"
      Import.grab_youtube_video(url) # only youtube so far
      puts "mark downloaded"
      Import.mark_video_completed(url)
    end
    # flvs_to_convert = Import.get_all_downloaded_flvs()
    # if !flvs_to_convert.empty?
    #   flvs_to_convert.each do |flv_path|
    #     puts "converting #{flv_path}"
    #     Import.convert_flv_to_mp4(flv_path)
    #     Import.move_mp4_to_itunes("#{flv_path}.mp4")
    #     puts "delete the flv"
    #     File.delete flv_path
    #   end
    # end
  end
end