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
    if torrent.complete? && TorrentFile.where(torrent_hash: params[:hash])==[]
      TorrentFile.create(torrent_hash: params[:hash], file_path: path, fetched: true)
      Myfile.fetch_files(path,"*")
    end
    redirect :back
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
