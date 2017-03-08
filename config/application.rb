require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdminServer
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    %w(services exceptions pdfs).each do |folder|
      config.autoload_paths << Rails.root.join("app/#{folder}")
    end

    config.time_zone = 'New Delhi'

    # Use sidekiq to process jobs.
    config.active_job.queue_adapter = :sidekiq
  end
end
