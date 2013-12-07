raise "Please specify your LAYERVAULT_CLIENT_ID with `export LAYERVAULT_CLIENT_ID=MY_KEY" if ENV['LAYERVAULT_CLIENT_ID'].blank?
raise "Please specify your LAYERVAULT_CLIENT_SECRET with `export LAYERVAULT_CLIENT_ID=MY_KEY" if ENV['LAYERVAULT_CLIENT_SECRET'].blank?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :layervault,
    ENV['LAYERVAULT_CLIENT_ID'],
    ENV['LAYERVAULT_CLIENT_SECRET'],
    scope: "user",
    client_options: {
      site: "https://layervault.com"
    }
end