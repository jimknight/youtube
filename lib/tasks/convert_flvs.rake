desc "Convert all flvs to mp4s"
task :convert_flvs => :environment do
  flvs = Import.get_all_downloaded_flvs
  flvs.each do |flv|
    puts "Converting #{flv} to mp4"
    Import.convert_flv_to_mp4(flv)
  end
end