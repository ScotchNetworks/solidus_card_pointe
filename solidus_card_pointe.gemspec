# frozen_string_literal: true

require_relative 'lib/solidus_card_pointe/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_card_pointe'
  spec.version = SolidusCardPointe::VERSION
  spec.authors = ['Daniele Palombo']
  spec.email = '387690+DanielePalombo@users.noreply.github.com'

  spec.summary = 'A Solidus extension that integrates with the CardPointe payment gateway.'
  # rubocop:disable Layout/LineLength
  spec.description = 'A Solidus extension that provides integration with the CardPointe payment gateway, allowing Solidus-based e-commerce applications to process payments securely and efficiently through CardPointe.'
  # rubocop:enable Layout/LineLength
  spec.homepage = 'https://github.com/solidusio-contrib/solidus_card_pointe#readme'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/solidusio-contrib/solidus_card_pointe'
  spec.metadata['changelog_uri'] = 'https://github.com/solidusio-contrib/solidus_card_pointe/blob/main/CHANGELOG.md'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5', '< 4')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'solidus_core', ['>= 2.0.0', '< 5']
  spec.add_dependency 'solidus_support', '~> 0.5'

  spec.add_development_dependency 'solidus_dev_support', '~> 2.9'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
