require "thor"

module HueControl
  module Cli
    class Lights < Thor
      desc "list", "Lists all available lights"
      def list
        puts "%4s\t%-20s\t%s" % ["Nr", "Name", "Status"]
        puts "--------------------------------------"
        HueControl.lights.each do |k,v|
          puts "%4u\t%-20s\t%s" % [k, v["name"], v["state"]["on"] ? "on" : "off"]
        end
      end
    end
  end
end
