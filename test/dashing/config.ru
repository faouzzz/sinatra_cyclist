require 'sinatra/cyclist'
require 'dashing'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
      # Put any authentication code you want in here.
      # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

set :cycles_configuration, [
  {cycled_route: '_cycle', routes: [:sample, :sample2], cycle_duration: 2},
  {cycled_route: 'cycle', routes: [:sample2, :sample3, :sample4], cycle_duration: 5},
  {cycled_route: 'prod', routes: [:sample1, :sample6, :sample5, :sample4], cycle_duration: 10},
  {cycled_route: 'bad', routes: [], cycle_duration: 10}, # should redirect not_found
  {cycled_route: 'baad', routes: '', cycle_duration: 10}, # should redirect not_found
  {cycled_route: 'baaad', routes: nil, cycle_duration: 10}, # should redirect not_found
]

run Sinatra::Application
