module Sinatra
  module Thinkapi
    module Routing
      module Users

        def self.registered(app)
          show_users = lambda do
            load_users

            sorter = if params[:sort]
               params[:sort][0] == "-" ? settings.r.desc(params[:sort][1..-1]) : settings.r.asc(params[:sort])
             else
               nil
             end

            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('users').order_by(sorter).run(@rdb_connection))
          end

          app.get  '/users', &show_users
        end

      end
    end
  end
end
