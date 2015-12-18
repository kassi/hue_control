require "thor"
require "awesome_print"

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

      desc "state NR_OR_NAME", "Read or set a state for a specific light"
      method_option :on, type: :boolean, desc: "Sets state on or off"
      method_option :bri, type: :numeric, desc: "Sets brightness (0-254)"
      method_option :xy, type: :array, desc: "Sets xy value inside Gamut triangle"
      method_option :ct, type: :numeric, desc: "Sets color temperature in reciprocal megakelvin (mirek) (153-500)"
      method_option :hue, type: :numeric, desc: "Sets hue (0-65280)"
      method_option :sat, type: :numeric, desc: "Sets saturation (25-200)"
      def state(nr_or_name)
        nr_or_name = HueControl.lights_number(nr_or_name) unless nr_or_name =~ /^\d+$/
        if options.empty?
          ap HueControl.get("/lights/#{nr_or_name}")
        else
          HueControl.put("/lights/#{nr_or_name}/state", options)
        end
      end
    end
  end
end
