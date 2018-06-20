require 'rackgame/version'

ROUTES = {
  '/' => 'home#index'
}.freeze

module Rackgame
  class App
    def initialize
      @router = Router.new(ROUTES)
    end

    def call(env)
      request = Rack::Request.new(env)
      router.resolve(request)
    end

    def self.root
      File.expand_path('..', Dir.pwd)
    end
  end
end
