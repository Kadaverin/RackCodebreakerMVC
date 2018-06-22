require 'slim'
require_relative 'rackgame/version'
require_relative 'rackgame/router'
require_relative 'rackgame/controller'
require 'codebreaker'

Dir[File.join(__dir__, '..', 'app', '**', '*.rb')].each do |file|
  require file
end

ROUTES = {
  '/' => 'home#index',
  '/start' => 'game#index',
  '/game' => 'game#game',
  '/guess' => 'game#guess',
  '/hint' => 'game#hint',
  '/save_score' => 'score#ask_for_save',
  '/score_list' => 'score#score_list'
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
