# Sinatra Cyclist Multi

This is a fork of the original gem [vrish88/sinatra_cyclist](https://github.com/vrish88/sinatra_cyclist), thank you vrish88.

Added option to use multiple cycled routes.

|  cycled routes           |  routes pages                         |  cycle time  |
|--------------------------|---------------------------------------|--------------|
| first-cycled-route       | ['dashboard1', 'dashboard2', 'dash3'] |  10          |
| another-cycled-route     | ['dashboard12', 'dashboardY']         |  5           |
| prod-cycle-route         | ['dashi', 'dashou', 'dashbord36']     |  45          |


## Installation

Add this line to your application's Gemfile:

    gem 'sinatra_cyclist_multi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_cyclist_multi

Installation into your code depends on how you are using Sinatra.

## Configuration

If you need only one cycled route you can use [vrish88/sinatra_cyclist](https://github.com/vrish88/sinatra_cyclist) gem or set only one cycled route:

```ruby
  set :cycles_configuration, [
    {cycled_route: '_cycle', routes: [:page1, :page2], cycle_duration: 15},
    {cycled_route: '_cycle2', routes: [:page12, :page3, :page4], cycle_duration: 5},
    {cycled_route: '_prod', routes: [:page7, :page4, :page5, :page6], cycle_duration: 45},
  ]
```

### Dashing
If you are using [dashing](https://github.com/Shopify/dashing) update your `config.ru` to look something like:

```ruby
require "sinatra/cyclist"
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
  {cycled_route: '_cycle', routes: [:page1, :page2], cycle_duration: 15},
  {cycled_route: '_cycle2', routes: [:page12, :page3, :page4], cycle_duration: 5},
  {cycled_route: '_prod', routes: [:page7, :page4, :page5, :page6], cycle_duration: 45},
]

run Sinatra::Application
```

* Require `sinatra_cyclist_multi` before `dashing` otherwise you will see this error:

    > No such file or directory - sample/dashboards/_cycle.erb

* Set the `routes_to_cycle_through` before running the application.

### Classic Applications
Require the gem and specify the routes you want to cycle through.

```ruby
require "sinatra"
require "sinatra/cyclist"

set :cycles_configuration, [
  {cycled_route: '_cycle', routes: [:page1, :page2], cycle_duration: 30},
]

get "/page_1" do
  "Page 1"
end

get "/page_2" do
  "Page 2"
end
```

### Modular Applications
Require the gem, explicitly register the extension, and specify the routes.
```ruby
require "sinatra/base"
require "sinatra/cyclist"

class MyApp < Sinatra::Base
  register Sinatra::Cyclist

  set :cycles_configuration, [
    {cycled_route: '_cycle', routes: [:page1, :page2], cycle_duration: 30},
  ]

  get "/page_1" do
    "Page 1"
  end

  get "/page_2" do
    "Page 2"
  end
end
```

## Usage
Now visit one of your configured cycled routes `/_cycle/#{cycled_route}` to start cycling!

You can also specify a duration (in seconds) in the params to the cycle action

```
http://sinatra_app.com/_cycle/#{cycled_route}?duration=10
```

/!\ **Do not use this gem with the original, it will conflict** /!\


## Try it with on Dashing
You can try with the **Dockerfile** in test folder. Considering you have a working docker installation you can run:

```shell
  cd sinatra_cyclist_multi/test
  docker build -t nfaa/cyclist . && docker run --name cyclist -p8080:3030 nfaa/cyclist
```

There are three cycled routes configured:
```
  http://{docker host ip}:8080/_cycle/_cycle
  http://{docker host ip}:8080/_cycle/cycle
  http://{docker host ip}:8080/_cycle/prod
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

