module Sinatra
  module Thinkapi
    module Routing
      module Challenges

        def self.registered(app)
          show_challenges = lambda do
            load_challenges
            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('challenges').run(@rdb_connection))
          end

          app.get  '/challenges', &show_challenges
        end

      end
    end
  end
end
