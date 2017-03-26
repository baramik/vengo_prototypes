# # Set the following ENV variables:
# #     ENV['S3_BUCKET_NAME'],
# #     ENV['AWS_ACCESS_KEY_ID'],
# #     ENV['AWS_SECRET_ACCESS_KEY']
# #     ENV['AWS_REGION']
# #

module ElasticTranscoder
  class TranscodeVideo
    require 'aws-sdk'
    def initialize
      @elastictranscoder = Aws::ElasticTranscoder::Client.new(region: ENV['AWS_REGION'])
      @s3 = Aws::S3::Client.new(region: ENV['AWS_REGION']) 
      @pipeline_id = '1489976071840-hwa5xd'
    end

    # time_span: {start_time: '00:00:00.000', duration: '00:00:15.000' }
    def create_job(key_input, preset_id, start_time, duration)
      preset = list_presets.find {|s| s.id == preset_id } 
      key_output = key_input.split('.').first + SecureRandom.hex(13) + '.' + preset.container
      input_params = { key: key_input, frame_rate: 'auto', resolution: 'auto', aspect_ratio: 'auto', interlaced: 'auto', container: 'auto'}
       
      if  start_time != '00:00:00.000' || duration != 'auto'
        input_params[:time_span] = {}
        input_params[:time_span].merge!({start_time: start_time}) unless start_time == '00:00:00.000' 
        input_params[:time_span].merge!({duration: duration}) unless duration == 'auto'
      end   
      job = @elastictranscoder.create_job( pipeline_id: @pipeline_id,
        input: input_params,
        output: { key: key_output, preset_id: preset_id, thumbnail_pattern: "", rotate: '0'} )
      return job, key_output
    end

    def list_jobs(id)
      begin 
        @elastictranscoder.list_jobs_by_pipeline(pipeline_id: id)[:jobs]
      rescue
        #Raise informative exception
      end
    end

    def list_presets
      begin
        @elastictranscoder.list_presets[:presets]
      rescue
        #Raise informative exception
      end
    end
    
    def read_job(job_id)
      job = @elastictranscoder.read_job({id: job_id}).job
      if job.status == "Complete"
        @s3.put_object_acl({acl: "public-read",  key: job.output.key, bucket: ENV['S3_BUCKET_NAME'] }) 
      end
      job
    end
  end
end
