require "thor"

module HueControl
  module Cli
    class Application < Thor
      include Thor::Actions
    end
  end
end
