# frozen_string_literal: true

require_relative 'touchscreen_taps/libinput'
require_relative 'touchscreen_taps/touchscreen_device'
require_relative 'touchscreen_taps/gesture_buffer'
require_relative 'touchscreen_taps/config'
require_relative 'touchscreen_taps/event'
require_relative 'touchscreen_taps/event_filter'
require_relative 'touchscreen_taps/event_parser'
require_relative 'touchscreen_taps/tap_and_hold_detector'
require_relative 'touchscreen_taps/executor'

module TouchscreenTaps
  # Main runner
  class Runner
    def initialize(config_path)
      config       = Config.new(config_path)
      @buffer      = config.buffer
      @touchscreen = config.touchscreen
      @detector    = TapAndHoldDetector.new(config)
      @executor    = Executor.new(config)
    end

    def process_events
      Libinput.events(@touchscreen) do |event|
        event = EventFilter.call(event)
        next unless event

        event = EventParser.call(event)
        @buffer.push(event)
        command = @detector.process(@buffer)
        @executor.run(command)
      end
    end
  end
end
