require 'digest/md5'
require 'fileutils'
class Myfile < ActiveRecord::Base
  
  def self.fetch_files(path, type)
    md5s=Myfile.all.pluck(:file_md5)
    Dir["#{path}/**/*.#{type}"].each do |file|
     unless File.directory?(file)
      md5=Digest::MD5.file(file)
      unless md5s.include? md5 
        Myfile.create(file_name: File.basename(file), file_md5: md5, file_path: file)
      end
     end
    end    
  end
  def self.regist_file(file)
      md5=Digest::MD5.file(file)
      Myfile.create(file_name: File.basename(file), file_md5: md5, file_path: file)
  end
  def can_play?
    %{mp4 mp3}.split(" ").include?(file_path.split(".")[-1]) ? true : false
  end
end
