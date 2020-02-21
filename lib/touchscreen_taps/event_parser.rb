# frozen_string_literal: true

module TouchscreenTaps
  # Parses a raw line and creates an event object
  class EventParser
    class << self
      def call(event)
        _device, event_name, _time, text = event.strip.split(nil, 4)
        Event.new(type(event_name), finger(text), *direction(text))
      end

      private

      def direction(text)
        return if text.nil?

        _finger, _finger2, x, y = text.tr('/|(|)', ' ').split
        [x, y]
      end

      def type(text)
        text.split('_').last
      end

      def finger(text)
        return if text.nil?

        count, = text.split(nil, 3)
        count.to_i + 1
      end
    end
  end
end
