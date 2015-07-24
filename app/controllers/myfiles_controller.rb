class MyfilesController < ApplicationController
  before_action :set_myfile, only: [:show, :edit, :update, :destroy]

  # GET /myfiles
  # GET /myfiles.json
  def index
    @myfiles = Myfile.all
  end

  # GET /myfiles/1
  # GET /myfiles/1.json
  def show
  end

  # GET /myfiles/new
  def new
    @myfile = Myfile.new
  end

  # GET /myfiles/1/edit
  def edit
  end

  # POST /myfiles
  # POST /myfiles.json
  def create
    if params[:myfile][:upload_file].blank?
        flash[:error] = 'file can not be null'
        redirect_to :back
        return
    else
        upload_file = params[:myfile][:upload_file]
        file_name = upload_file.original_filename
        File.open("uploads/#{file_name}", 'wb') do |f|
          f.write(upload_file.read)
        end
        Myfile.regist_file("uploads/#{file_name}")
    end
    redirect_to myfiles_path 
  end

  # PATCH/PUT /myfiles/1
  # PATCH/PUT /myfiles/1.json
  def update
    respond_to do |format|
      if @myfile.update(file_name: myfile_params[:file_name])
        format.html { redirect_to @myfile, notice: 'Myfile was successfully updated.' }
        format.json { render :show, status: :ok, location: @myfile }
      else
        format.html { render :edit }
        format.json { render json: @myfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myfiles/1
  # DELETE /myfiles/1.json
  def destroy
     FileUtils.rm(@myfile.file_path) if Myfile.where(file_md5: @myfile.file_md5) > 1
    @myfile.destroy
    respond_to do |format|
      format.html { redirect_to myfiles_url, notice: 'Myfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  def play_url
    send_file Myfile.where(file_md5: params[:hash]).first.file_path,:type => "video/mp4"
  end

  def play
    @file=Myfile.find(params[:id])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_myfile
      @myfile = Myfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def myfile_params
      params.require(:myfile).permit(:file_name, :file_path, :file_md5)
    end
end
