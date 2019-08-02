require './lib/app'

use Rack::Session::Cookie,
    key: 'rack.session',
    path: '/',
    expire_after: 2_592_000

use Rack::Static,
    urls: ['/css', '/js', '/img'],
    root: 'app/public'

run Rackgame::App.new
