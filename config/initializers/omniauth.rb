OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '122937648345181', '1859d305b90ec8cb3ce45c14587b3c11'
end