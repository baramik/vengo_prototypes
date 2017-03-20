CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                 
  config.fog_credentials = {
    provider:              'AWS',                        
    aws_access_key_id:     'AKIAJP46TPEKMD4NFPCA',                      
    aws_secret_access_key: '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',                     
    region:                'oregon'
  }
  config.fog_directory  = 'vengovideo'        
end