# frozen_string_literal: true

module TouchscreenTaps
  # represents a physical input device (e.g touchscreen)
  class TouchscreenDevice
    REQUIRED_CAPABILITY = 'touch'
    attr_reader :kernel

    def initialize(kernel)
      @kernel = kernel
    end

    class << self
      def select_from(devices)
        devices.map do |device|
          next unless capable?(device)

          kernel = kernel_path(device)
          new(kernel) unless kernel.nil?
        end.compact
      end

      private

      def capable?(device)
        device.find { |f| f =~ /^Capabilities:/ }
              .include?(REQUIRED_CAPABILITY)
      end

      def kernel_path(device)
        device.find { |f| f =~ /^Kernel:/ }.split(' ').last
      end
    end
  end
end
