require 'vcr'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<AUTHORIZATION>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end

  config.filter_sensitive_data('<MERCHANT_ID>') do |interaction|
    body = JSON.parse(interaction.request.body)
    body['merchid']
  end

  config.filter_sensitive_data('<AUTHORIZATION>') { ENV['CARD_POINTE_AUTHORIZATION'] }
  config.filter_sensitive_data('<MERCHANT_ID>') { ENV['CARD_POINTE_MERCHANT_ID'] }
  config.default_cassette_options = { record: :once }
end
