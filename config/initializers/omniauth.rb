OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FB_APP_ID"] || '122937648345181', ENV["FB_APP_SECRET"] || '1859d305b90ec8cb3ce45c14587b3c11'
end