# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusCardPointe
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_card_pointe'

    initializer "solidus_card_pointe.add_static_preference", after: "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << 'SolidusCardPointe::PaymentMethod'
      app.config.to_prepare do
        Spree::Config.static_model_preferences.add(
          ::SolidusCardPointe::PaymentMethod,
          'card_pointe_credentials',
          ::SolidusCardPointe::Engine.card_pointe_credentials_hash
        )
      end

      Spree::PermittedAttributes.source_attributes.concat(%i[
        card_token
      ])
    end

    initializer 'solidus_card_pointe.add_view_paths' do |_app|
      paths = ActionController::Base.view_paths.to_a
      index = paths.find_index { |p| p.to_s.include?('solidus_frontend') }

      ActionController::Base.view_paths = paths.insert(
        index || 0,
        Rails::Engine.subclasses.detect { |e|
          e.name == 'SolidusCardPointe::Engine'
        }.root.join('app/views')
      )
    end

    class << self
      def card_pointe_credentials_hash
        {
          card_pointe_authorization: ENV['CARD_POINTE_AUTHORIZATION'],
          card_pointe_merchant_id: ENV['CARD_POINTE_MERCHANT_ID'],
          card_pointe_domain: ENV['CARD_POINTE_DOMAIN']
        }
      end
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
