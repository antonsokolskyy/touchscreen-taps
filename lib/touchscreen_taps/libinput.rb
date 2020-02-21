# frozen_string_literal: true

module TouchscreenTaps
  # libinput wrapper
  # makes debug_events available in ruby
  class Libinput
    require 'open3'

    class << self
      def events(device = nil)
        Open3.popen3(debug_events_cmd(device)) do |_in, out, _err, _wait_thr|
          out.each do |event|
            yield(event.chomp)
          end
        end
      end

      def devices
        Open3.popen3(list_devices_cmd) do |_in, out, _err, _wait_thr|
          out.read.split("\n\n").map { |d| d.split("\n") }
        end
      end

      private

      def debug_events_cmd(device)
        'stdbuf -oL -- libinput debug-events' \
        "#{' --device=' + device.kernel unless device.nil?}"
      end

      def list_devices_cmd
        'libinput list-devices'
      end
    end
  end
end
