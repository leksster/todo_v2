Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '189696791421969', '5deccb3ea0c6e9c9eb5b6f3e0f16c9a3'
end