require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Airfryer
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.default_locale = :ko
    config.time_zone = 'Seoul'

  end
end
