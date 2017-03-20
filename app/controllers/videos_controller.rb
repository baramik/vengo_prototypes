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

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
  end
  
  def task_params
    params.require(:video).permit(:file)
  end
  
  def jobs
    transcode_video = ElasticTranscoder::TranscodeVideo.new
    @jobs = transcode_video.list_jobs params[:id]
    puts @jobs
  end
  
  def execute
    transcode_video = ElasticTranscoder::TranscodeVideo.new
    transcode_video.create_job params[:preset], params[:input_file], params[:output_folder]
  end
  
end