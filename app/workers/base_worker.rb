class BaseWorker
  include Sidekiq::Worker
  sidekiq_options queue: "pummeldoge_#{Rails.env.to_s}"
end