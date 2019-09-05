Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '405319146759777', '350475a5f35e7ea70d3659fa58f56a3e'
  provider :linkedin, '77apwp59c4g58f', '0Zu8jK0n9GNfpG4E'
end