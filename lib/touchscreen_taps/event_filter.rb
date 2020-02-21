# frozen_string_literal: true

module TouchscreenTaps
  # Allows only necessary events
  class EventFilter
    class << self
      def call(event)
        return unless event =~ /TOUCH_UP|TOUCH_DOWN|TOUCH_MOTION/

        event
      end
    end
  end
end
