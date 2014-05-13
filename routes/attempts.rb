module Sinatra
  module Thinkapi
    module Routing
      module Attempts

        def self.registered(app)
          show_attempts = lambda do
            load_attempts
            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('attempts').run(@rdb_connection))
          end

          app.get  '/attempts', &show_attempts
        end

      end
    end
  end
end
