# frozen_string_literal: true

module TouchscreenTaps
  # Executes commands from config file
  class Executor
    def initialize(config)
      @config = config
    end

    def run(cmd)
      return if cmd.nil?

      command = @config.by_keys(command_to_keys(cmd)).fetch('command')
      execute(command) if command
    end

    private

    def execute(command)
      puts "Executing '#{command}'"
      fork do
        Process.daemon(true)
        exec(command)
      end
    end

    def command_to_keys(cmd)
      [cmd[:name], cmd[:fingers]]
    end
  end
end
