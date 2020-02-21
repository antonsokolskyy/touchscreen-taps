# frozen_string_literal: true

module TouchscreenTaps
  # Parsed Event object
  class Event
    attr_reader :timestamp
    attr_reader :type
    attr_reader :finger
    attr_reader :move_x
    attr_reader :move_y

    def initialize(type, finger, move_x = nil, move_y = nil)
      @type = type
      @finger = finger
      @move_x = move_x
      @move_y = move_y
      @timestamp = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end
  end
end
