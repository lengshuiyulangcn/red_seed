require 'shellwords'
class TorrentsController < ApplicationController
  def index
    @torrents=Torrent.all
  end
  def delete
    torrent=Torrent.new params[:hash]
    torrent.delete
    redirect_to :back
  end
  def stop
    torrent=Torrent.new params[:hash]
    torrent.stop
    redirect_to :back
  end
  def start
    torrent=Torrent.new params[:hash]
    torrent.start
    redirect_to :back
  end
  def new
  end

  def fetch
    torrent=Torrent.new params[:hash]
    path=torrent.file_path
    if torrent.complete? && Video.where(seed_hash: params[:hash]).empty?
      Dir[path.shellescape+"/*"].each do |file|
        Video.create(seed_hash: params[:hash], path: file, base_name: torrent.name) if file.split(".")[-1]=="mp4"
      end
    end
    redirect_to :back
  end
  def create
    url=params[:torrent][:url]
    if url.blank?
        flash[:error] = 'file can not be null'
    else
      Torrent.create_from_url(url)
      redirect_to torrents_path
    end
  end
end
