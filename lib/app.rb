require_relative 'rackgame/version'
require_relative 'rackgame/router'
require_relative 'rackgame/controller'
require 'slim'
require 'yaml'
require 'codebreaker'

Dir[File.join(__dir__, '..', 'app', '**', '*.rb')].each do |file|
  require file
end

ROUTES = YAML.safe_load(
  File.read(File.join(__dir__, '..', 'app', 'routes', 'web.yml'))
)

module Rackgame
  # //
  class App
    attr_reader :router
    def initialize
      @router = Router.new(ROUTES)
    end

    def call(env)
      request = Rack::Request.new(env)
      router.resolve(request).response.finish
    end

    def self.root
      File.expand_path('..', __dir__)
    end
  end
end
