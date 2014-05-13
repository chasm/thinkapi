module Sinatra
  module Thinkapi
    module Routing
      module Categories

        def self.registered(app)
          show_categories = lambda do
            load_categories
            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('categories').run(@rdb_connection))
          end

          app.get  '/categories', &show_categories
        end

      end
    end
  end
end
