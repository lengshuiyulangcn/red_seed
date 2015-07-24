module ApplicationHelper
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
