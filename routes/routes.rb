module Sinatra
  module Thinkapi
    module Routing
      module Routes

        def self.registered(app)
          show_routes = lambda do
            @out = []
            app.each_route do |route|
              h = {}
              h[:path]       = route.path       # that's the path given as argument to get and akin
              h[:verb]       = route.verb       # get / head / post / put / delete
              h[:file]       = route.file       # "some_sinatra_app.rb" or something
              h[:line]       = route.line       # the line number of the get/post/... statement
              h[:pattern]    = route.pattern    # that's the pattern internally used by sinatra
              h[:keys]       = route.keys       # keys given when route was defined
              h[:conditions] = route.conditions # conditions given when route was defined
              @out << h
            end
            @out.sort! {|a,b| [ a[:path], a[:verb] ] <=> [ b[:path], b[:verb] ] }
            erb :routes, layout: :application
          end

          app.get  '/routes', &show_routes
        end

      end
    end
  end
end
