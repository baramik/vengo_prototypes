CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                 
  config.fog_credentials = {
    provider:              'AWS',                        
    aws_access_key_id:     'AKIAIN7VKY2U5CK3YRCA',                      
    aws_secret_access_key: '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',                     
    region:                'us-west-2'
  }
  config.fog_directory  = 'vengovideo'        
end