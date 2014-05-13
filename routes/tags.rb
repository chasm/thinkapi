module Sinatra
  module Thinkapi
    module Routing
      module Tags

        def self.registered(app)
          show_tags = lambda do
            load_tags
            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('tags').order_by(settings.r.desc('name')).run(@rdb_connection))
          end

          app.get  '/tags', &show_tags
        end

      end
    end
  end
end
