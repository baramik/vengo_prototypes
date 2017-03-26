class VideosController < ApplicationController
  require 'elastic_transcoder'
  
  def index
    @videos = Video.all
    respond_to do |format|
      format.html 
      format.json { render :json => @videos.collect { |p| p }.to_json  }
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
    @presets = ElasticTranscoder::TranscodeVideo.new.list_presets
  end

  def create
    @video = Video.create(task_params)
  end
  
  def update
    @video = Video.find(params[:id])
    @video.save_preview_to_file
    redirect_to videos_path
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path
  end
  
   def job_transcoder
    job = ElasticTranscoder::TranscodeVideo.new.read_job params[:job_id]
    render json: job
  end
  
  def execute_transcoder
    @job, key_output = ElasticTranscoder::TranscodeVideo.new.create_job params[:key_input], params[:presets], params[:start_time], params[:duration]
    @preview = Video.find(params[:id]).save_preview(key_output)
  end
  
  def task_params
    params.require(:video).permit(:file)
  end
end
