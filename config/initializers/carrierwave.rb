CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider => 'AWS',
        :aws_access_key_id => 'AKIAJ3WUKF3SSH2ZLENQ',
        :aws_secret_access_key => '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', 
    }
    config.fog_directory = 'Whipplee'
    #config.s3_region = 'us-standard'
    config.fog_public     = true  # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}

end