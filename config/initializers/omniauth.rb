Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '372352390324564', '4a65a6ddc490b23f8a658973cc4c601a'
  provider :linkedin, '77apwp59c4g58f', '0Zu8jK0n9GNfpG4E'
end