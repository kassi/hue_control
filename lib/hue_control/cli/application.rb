require "thor"
require "hue_control/cli/lights"

module HueControl
  module Cli
    class Application < Thor
      include Thor::Actions

      desc "init", "Create initialization file"
      def init
        if File.exists?(CONFIG_FILE)
          abort unless yes?("Config file already exists. Sure you want to overwrite it?")
        end
        File.write(CONFIG_FILE, "---\nip: YOUR_IP_HERE\nusername: YOUR_USERNAME_HERE\n")
        puts "Config file created."
        puts "Please edit #{CONFIG_FILE} and enter IP of the hue base and your api username."
      end

      desc "lights", "Lights control"
      subcommand "lights", HueControl::Cli::Lights
    end
  end
end
