require "sinatra/base"
require_relative "cyclist/version"

module Sinatra
  module Cyclist
    def self.registered(app)
      app.enable :sessions
      app.set :cycles_configuration, []

      app.get "/_cycle/:cycled_route" do
        not_found if
          settings.cycles_configuration.empty? or
          settings.cycles_configuration.select{ |cycle|
            cycle[:cycled_route] == params['cycled_route'] &&
            cycle[:routes].is_a?(Array) &&
            !cycle[:routes].empty?
          }.empty?

        cycle = settings.cycles_configuration.select{ |cycle|
          cycle[:cycled_route] == params['cycled_route']
        }.first

        page_index = session[:_cycle_page_index] || -1
        session[:_cycle_page_index] = page_index + 1

        number_of_routes = cycle[:routes].length
        page = cycle[:routes][session[:_cycle_page_index] % number_of_routes]

        session[:_cycle_duration] = params[:duration] if params[:duration]
        session[:_cycle_duration] = cycle[:cycle_duration]
        session[:_cycled_route] = cycle[:cycled_route]
        session[:_cycle] = true

        redirect "/#{page}"
      end

      app.before do
        if session[:_cycle]
          headers["Refresh"] = "#{session[:_cycle_duration]}; url=/_cycle/#{session[:_cycled_route]}"
          session[:_cycle] = false
        end
      end
    end
  end

  register Cyclist
end
