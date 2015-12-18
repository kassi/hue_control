require "hue_control/version"
require "hue_control/cli/application"
require "yaml"
require "rest-client"

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

  def self.get(path)
    response = RestClient.get(url(path))
    JSON.parse(response.body)
  end

  def self.put(path, body)
    response = RestClient.put(url(path), body.to_json, accept: :json, content_type: :json)
    JSON.parse(response.body)
  end

  def self.lights
    @@lights ||= self.get_lights
  end

  def self.lights=(lights)
    @@lights = lights
  end

  def self.lights_number(name)
    lights.select {|k,v| v["name"] == name}.keys.first
  end

  private

  def self.url(path)
    "http://%s/api/%s%s" % [config["ip"], config["username"], path]
  end

  def self.get_lights
    self.get("/lights")
  end
end
