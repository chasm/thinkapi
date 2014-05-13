module Sinatra
  module Thinkapi
    module Routing
      module Tasks

        def self.registered(app)
          show_tasks = lambda do
            load_tasks
            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('tasks').run(@rdb_connection))
          end

          app.get  '/tasks', &show_tasks
        end

      end
    end
  end
end
