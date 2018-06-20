require 'slim'
require_relative 'rackgame/version'
require_relative 'rackgame/router'
require_relative 'rackgame/controller'

Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].each do |file|
  require file
end

ROUTES = {
  '/' => 'home#index'
}.freeze

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
