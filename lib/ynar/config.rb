# frozen_string_literal: true

require 'yaml'

module Ynar
  class Config
    attr_reader :personal_access_token

    def initialize(config_path)
      config = YAML.safe_load(File.read(config_path))
      @personal_access_token = config['personal_access_token']
    end
  end
end
