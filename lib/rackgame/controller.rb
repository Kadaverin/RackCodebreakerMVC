module Rackgame
  # //
  class Controller
    attr_reader :name, :action
    attr_accessor :response, :request

    def initialize(name: nil, action: nil, request: nil)
      @name = name
      @action = action
      @request = request
      @redirect = false
    end

    def call
      @redirect = false
      send(action)

      unless @redirect
        self.response = Rack::Response.new do |response|
          response.body = [template.render(self)]
          # for the future : make the status code dependent on the request method
          response.status = 200
          response.set_header('Content-Type', 'text/html')
        end
      end

      self
    end

    def not_found
      self.response = Rack::Response.new(['Nothing found'], 404)
      self
    end

    def internal_error
      self.response = Rack::Response.new(['Internal error'], 500)
      self
    end

    def redirect(path)
      @redirect = true
      self.response = Rack::Response.new { |r| r.redirect(path) }
    end

    def template
      path = File.join(App.root, 'app', 'views', name, "#{action}.slim")
      Slim::Template.new(path)
    end
  end
end
