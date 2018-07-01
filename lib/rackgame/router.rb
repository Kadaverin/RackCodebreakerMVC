module Rackgame
  # //
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
        Controller.new.not_found
      end
    rescue Exception => error
      show_server_error(error)
    end

    private def controller(route_string, request)
      name, action = route_string.split('#')
      ctlr_class = Object.const_get("#{name.capitalize}Controller")
      ctlr_class.new(name: name, action: action, request: request)
    end

    private def show_server_error(error)
      puts error.message
      puts error.backtrace
      Controller.new.internal_error
    end
  end
end
