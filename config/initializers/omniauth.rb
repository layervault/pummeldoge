Rails.application.config.middleware.use OmniAuth::Builder do
  provider :layervault,
    ENV['LAYERVAULT_CLIENT_ID'],
    ENV['LAYERVAULT_CLIENT_SECRET'],
    scope: "user",
    client_options: {
      site: "https://layervault.com"
    }
end