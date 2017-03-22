CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                 
  config.fog_credentials = {
    provider:              'AWS',                        
    aws_access_key_id:     'AKIAJSD2OJ6KDJGMUJ5A',                      
    aws_secret_access_key: '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',                     
    region:                'us-west-2'
  }
  config.fog_directory  = 'vengovideo'        
end