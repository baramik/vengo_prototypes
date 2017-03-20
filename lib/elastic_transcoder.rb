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
      @elastictranscoder = Aws::ElasticTranscoder::Client.new(region: 'us-west-2')
      @pipeline_id = '1489976071840-hwa5xd'
    end

    def create_job(preset_id, input_file, output_file)
      @elastictranscoder.create_job(
        pipeline_id: @pipeline_id,
        input: {
          key: input_file,
        },
        outputs: [
          {
            key: output_file,
            thumbnail_pattern: "thumb-{count}-{resolution}", #thumbnail generation based on pattern
            preset_id: preset_id
          }
        ]
      )
    end

    def list_jobs id
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
  end
end
