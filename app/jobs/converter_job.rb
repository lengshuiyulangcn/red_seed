class ConverterJob < ActiveJob::Base
  queue_as :default

  def perform(video)
    movie = FFMPEG::Movie.new(video.path)
    mp4_path = video.path.split(".")[0..-2].push("mp4").join(".")
    unless movie.valid?
      Video.destroy(video) 
    else
      movie.transcode(mp4_path)
      File.delete(video.path) if File.exist?(video.path)
      video.update(path: mp4_path, status: "converted") 
    end
  end
end
