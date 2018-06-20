require './lib/app'

use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           expire_after: 2_592_000

run Rackgame::App.new
