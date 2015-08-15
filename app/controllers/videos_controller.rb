class VideosController < ApplicationController
  def play_url
    videos=Video.where(seed_hash: params[:hash])
    redirect_to :back if videos.empty?
    path=videos.first.path
    send_file path, :stream=>true, :type => "video/mp4"
  end
  def play_video
    @hash=params[:hash]
    video=Video.find(params[:id])
    path=video.path
    @path='/'+path.split('/')[-3..-1].join('/')
    @name=video.base_name
  end
  def destroy
    Video.find(params[:id]).delete
    redirect_to :back
  end
end
