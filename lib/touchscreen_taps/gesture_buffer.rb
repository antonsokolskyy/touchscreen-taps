# frozen_string_literal: true

module TouchscreenTaps
  # Buffer for all events related to a single gesture
  # Gesture is considered started when first finger touches the screen
  # Gesture is considired ended when last finger leaves the screen
  # Between start and end points at least one finger
  # should be touching the screen
  class GestureBuffer
    TIME_TO_KEEP = 3 # seconds
    UP_TYPE = 'UP'
    DOWN_TYPE = 'DOWN'
    MOTION_TYPE = 'MOTION'
    attr_reader :events

    def initialize
      @events = []
    end

    def push(event)
      delete_old_events
      clear unless gesture_in_progress?
      remove_previous_events(event) if repeating_touch?(event)

      @events.push(event)
    end

    def empty?
      @events.empty?
    end

    def gesture_in_progress?
      down_touches.count > up_touches.count
    end

    def down_touches
      events_by_type(DOWN_TYPE)
    end

    def up_touches
      events_by_type(UP_TYPE)
    end

    def motion_touches
      events_by_type(MOTION_TYPE)
    end

    private

    def delete_old_events
      @events.each do |event|
        next if (current_time - event.timestamp) < TIME_TO_KEEP

        @events.delete(event)
      end
    end

    def clear
      @events.clear
    end

    def current_time
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    def repeating_touch?(event)
      return false unless event.type == DOWN_TYPE

      !@events.find { |e| e.finger == event.finger }.nil?
    end

    def remove_previous_events(event)
      @events.select { |e| e.finger == event.finger }.each do |e|
        @events.delete(e)
      end
      @events.delete(@events.find { |e| e.type == UP_TYPE })
    end

    def events_by_type(type)
      @events.select { |e| e.type == type }
    end
  end
end
