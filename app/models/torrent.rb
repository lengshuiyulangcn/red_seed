require 'xmlrpc/client'
class Torrent
  attr_reader :hash
  @@client = XMLRPC::Client.new2("http://49.212.212.212/RPC2")  
  def initialize(hash)
    @hash=hash
  end
  class << self
      def all
        @@client.call("download_list",'').map{|hash| Torrent.new(hash)}
      end
      def first
        Torrent.all.first
      end
      def last
        Torrent.all.last
      end
      def create_from_url url
        @@client.call("load_start",url)
      end
    end
  def stop
    @@client.call("d.stop",hash)
  end
  def complete?
    return true if  @@client.call("d.get_complete",hash)==1
    return false
  end
  def start
    @@client.call("d.start",hash)
  end
  def delete
    @@client.call("d.erase",hash)
  end
  def name
    @@client.call("d.get_base_filename",hash)
  end
  def path
    @@client.call("d.get_base_path",hash)
  end
  def download_speed
    @@client.call("d.get_down_rate",hash)
  end
  def upload_speed
    @@client.call("d.get_up_rate",hash)
  end
  def finished_bytes
    @@client.call("d.get_completed_bytes",hash)
  end
  def left_bytes
    @@client.call("d.get_left_bytes",hash)
  end
  def total_size
    finished_bytes+left_bytes
  end
  def finished_percentage
    (finished_bytes.to_f/(finished_bytes+left_bytes)).round(3)
  end
  def is_active?
    return true if @@client.call('d.is_active',hash)==1
    return false
  end

  def file_path
    @@client.call("d.get_base_path",hash)
  end
  def call_api(api)
    @@client.call(api,hash)
  end
end
