OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '296334074046930', 'd8d618d7c73885152f70242a3cafbf92',
  scope: 'email', info_fields: 'email',
  callback_url: 'http://calm-castle-74535.herokuapp.com/omniauth/facebook/callback/'
end
