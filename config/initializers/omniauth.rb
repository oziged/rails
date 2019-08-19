Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :facebook, '491409018257450', '8627d1688e929b90a6b919abefce44f8'
end