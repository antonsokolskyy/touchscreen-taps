# frozen_string_literal: true

module TouchscreenTaps
  # Holds main configurations
  class Config
    require 'yaml'

    attr_reader :buffer
    attr_reader :touchscreen

    def initialize(path = nil)
      @buffer      = fetch_buffer
      @touchscreen = fetch_touchscreen
      @config      = fetch_config(path)
    end

    def by_keys(keys)
      @config.dig(*keys)
    end

    private

    def fetch_buffer
      GestureBuffer.new
    end

    def fetch_touchscreen
      devices = Libinput.devices
      touchscreens = TouchscreenDevice.select_from(devices)
      # touchscreen can be nil
      # in that case events from all touch-capable devices will be processed
      touchscreens.count == 1 ? touchscreens.first : nil
    end

    def fetch_config(path)
      YAML.load_file(path || default_config_path)
    end

    def default_config_path
      "#{__dir__}/default_config.yml"
    end
  end
end
