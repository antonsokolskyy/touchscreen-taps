# frozen_string_literal: true

module TouchscreenTaps
  # Detects tap-and-hold gesture
  class TapAndHoldDetector
    COMMAND_TYPE = 'tap_and_hold'

    def initialize(config)
      @config = config
    end

    def process(buffer)
      return if return_conditions_met?(buffer)

      down_touches = buffer.down_touches
      up_touches   = buffer.up_touches

      last_down_touch = down_touches.max_by(&:timestamp)
      last_up_touch   = up_touches.max_by(&:timestamp)

      if hold_enough?(last_up_touch, last_down_touch)
        return { name: COMMAND_TYPE, fingers: down_touches.count }
      end

      nil
    end

    private

    def hold_enough?(up_touch, down_touch)
      return false if up_touch.nil? || down_touch.nil?

      required_delay = acceptance_delay(down_touch)
      return false if required_delay.nil?

      up_touch.timestamp - down_touch.timestamp > required_delay.to_f
    end

    def return_conditions_met?(buffer)
      buffer.empty? ||
        buffer.gesture_in_progress? ||
        buffer.motion_touches.any?
    end

    def acceptance_delay(down_touch)
      @config.by_keys([COMMAND_TYPE, down_touch.finger])
             &.fetch('acceptance_delay')
    end
  end
end
