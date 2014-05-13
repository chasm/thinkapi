ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'rethinkdb'
require 'sinatra/advanced_routes'
require 'active_support/all'

require_relative 'helpers'
require_relative 'routes/secrets'
require_relative 'routes/sessions'
require_relative 'routes/routes'
require_relative 'routes/users'
require_relative 'routes/tags'
require_relative 'routes/categories'
require_relative 'routes/challenges'
require_relative 'routes/inquiries'
require_relative 'routes/tasks'
require_relative 'routes/attempts'

class Thinkapi < Sinatra::Base

  set :root, File.dirname(__FILE__)

  RDB_CONFIG = {
    :host => ENV['RDB_HOST'] || 'localhost',
    :port => ENV['RDB_PORT'] || 28015,
    :db   => ENV['RDB_DB']   || 'davinci'
  }

  configure do
    set :r, RethinkDB::RQL.new
    set :db, RDB_CONFIG[:db]

    begin
      connection = settings.r.connect(:host => RDB_CONFIG[:host], :port => RDB_CONFIG[:port])
    rescue Exception => err
      puts "Cannot connect to RethinkDB database #{RDB_CONFIG[:host]}:#{RDB_CONFIG[:port]} (#{err.message})"
      Process.exit(1)
    end

    begin
      settings.r.db_create(RDB_CONFIG[:db]).run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Database `davinci` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('users').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `users` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('tags').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `tags` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('categories').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `categories` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('challenges').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `challenges` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('inquiries').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `inquiries` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('tasks').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `tasks` already exists."
    end

    begin
      settings.r.db(RDB_CONFIG[:db]).table_create('attempts').run(connection)
    rescue RethinkDB::RqlRuntimeError => err
      puts "Table `attempts` already exists."
    ensure
      connection.close
    end
  end

  before do
    begin
      # When openning a connection we can also specify the database:
      @rdb_connection = settings.r.connect(:host => RDB_CONFIG[:host], :port => RDB_CONFIG[:port], :db => settings.db)
    rescue Exception => err
      logger.error "Cannot connect to RethinkDB database #{RDB_CONFIG[:host]}:#{RDB_CONFIG[:port]} (#{err.message})"
      halt 501, 'This page could look nicer, unfortunately the error is the same: database not available.'
    end
  end

  # After each request we [close the database connection](http://www.rethinkdb.com/api/ruby/close/).
  after do
    begin
      @rdb_connection.close if @rdb_connection
    rescue
      logger.warn "Couldn't close connection"
    end
  end

  enable :sessions
  enable :method_override

  helpers Sinatra::Thinkapi::Helpers

  register Sinatra::AdvancedRoutes
  register Sinatra::Thinkapi::Routing::Sessions
  register Sinatra::Thinkapi::Routing::Secrets
  register Sinatra::Thinkapi::Routing::Routes
  register Sinatra::Thinkapi::Routing::Users
  register Sinatra::Thinkapi::Routing::Tags
  register Sinatra::Thinkapi::Routing::Categories
  register Sinatra::Thinkapi::Routing::Challenges
  register Sinatra::Thinkapi::Routing::Inquiries
  register Sinatra::Thinkapi::Routing::Tasks
  register Sinatra::Thinkapi::Routing::Attempts
end
