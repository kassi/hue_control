require "hue_control/version"
require "hue_control/cli/application"
require "yaml"

CONFIG_FILE = "#{ENV['HOME']}/.huerc"

module HueControl
  if File.exists?(CONFIG_FILE)
    @@config = YAML.load(File.read(CONFIG_FILE))
  else
    unless ARGV.include?("init")
      abort "Config file does not exist. Please create one first with `hue_control init`"
    end
  end

  def self.config
    @@config
  end
end
