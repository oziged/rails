Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '491409018257450', '8627d1688e929b90a6b919abefce44f8'
  provider :linkedin, '77apwp59c4g58f', '0Zu8jK0n9GNfpG4E'
end