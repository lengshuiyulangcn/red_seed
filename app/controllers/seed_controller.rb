class SeedController < WebsocketRails::BaseController
  def update_state
    info={}
    Torrent.all.each do |torrent|
      download_speed= format_speed torrent.download_speed
      upload_speed=  format_speed torrent.upload_speed
      percentage=(torrent.finished_percentage*100).round(3)
      item={download_speed: download_speed, upload_speed: upload_speed, percentage: percentage}
      info[torrent.hash]=item
    end
    send_message("system",info)
  end
  private
    def format_speed byte_speed
       if byte_speed/(1024*1024)>0
         return (byte_speed.to_f/(1024*1024)).round(3).to_s+"Mb/s"
       elsif byte_speed/1024 >0
         return (byte_speed.to_f/1024).round(3).to_s+"Kb/s"
       else
         return byte_speed.round(3).to_s+"b/s" 
       end
    end

end
