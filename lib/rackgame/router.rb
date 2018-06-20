module Rackgame
  class Router
    attr_reader :routes

    def initialize(routes)
      @routes = routes
    end

    def resolve(request)
      path = request.path

      if routes.key?(path)
        controller(routes[path], request).call
      else
        # handle not found
      end
    rescue Exception => error
      # handle server error
    end

    private def controller(route_string, request)
      name, action = route_string.split('#')
      ctlr_class = Object.const_get("#{name.capitalize}Controller")
      ctlr_class.new(name: name, action: action, request: request)
    end
  end
end
