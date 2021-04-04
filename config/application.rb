require_relative 'boot'

require 'rails/all'

def self.render_with_signed_in_user(user, *args)
  ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
  proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
  renderer = self.renderer.new('warden' => proxy)
  renderer.render(*args)
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CreatorsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ja

    # config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
  end

end
