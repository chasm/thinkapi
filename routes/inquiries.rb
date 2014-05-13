module Sinatra
  module Thinkapi
    module Routing
      module Inquiries

        def self.registered(app)
          show_inquiries = lambda do
            load_inquiries
            content_type :json

            ActiveSupport::JSON.encode(settings.r.table('inquiries').run(@rdb_connection))
          end

          app.get  '/inquiries', &show_inquiries
        end

      end
    end
  end
end
