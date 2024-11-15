# frozen_string_literal: true

module SolidusCardPointe
  class Configuration
    attr_accessor :card_pointe_merchant_id, :card_pointe_authorization, :card_pointe_url

    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      alias config configuration

      def configure
        yield configuration
      end
    end
  end
end
