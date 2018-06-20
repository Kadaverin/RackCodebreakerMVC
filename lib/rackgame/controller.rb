module Rackgame
  class Controller
    attr_reader :name, :action
    attr_accessor :response, :request

    def initialize(name: nil, action: nil, request: nil)
      @name = name
      @action = action
      @request = request
    end

    def call
      send(action)
      self.response = Rack::Response.new do |response|
        response.body = template.render(self)
        response.status = 200
        response.set_header('Content-Type', 'text/html')
      end
    end

    def template
      path = File.join(App.root, 'app', 'views', name.to_s, "#{action}.slim")
      Slim::Template.new(path)
    end
  end
end
