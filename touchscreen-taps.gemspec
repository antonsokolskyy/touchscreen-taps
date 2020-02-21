# frozen_string_literal: true

require_relative 'lib/touchscreen_taps/version'

Gem::Specification.new do |spec|
  spec.name          = 'touchscreen-taps'
  spec.version       = TouchscreenTaps::VERSION
  spec.authors       = ['Anton Sokolskyi']
  spec.email         = ['antonsokolskyi@gmail.com']

  spec.summary       = 'Touchscreen taps recognizer'
  spec.description   = 'Allows to recognize tap-and-hold gesture'
  spec.homepage      = 'https://github.com/antonsokolskyy/touchscreen-taps'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/antonsokolskyy/touchscreen-taps'
  spec.metadata['changelog_uri'] = 'https://github.com/antonsokolskyy/touchscreen-taps/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
