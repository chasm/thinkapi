require 'securerandom'
require 'bcrypt'

module Sinatra
  module Thinkapi
    module Helpers

      SALT = BCrypt::Engine.generate_salt
      FISH = BCrypt::Engine.hash_secret("123", SALT)

      USERS = [
        {
          id: SecureRandom.uuid,
          name: "Davy Jones",
          email: "davy.jones@munat.com",
          salt: SALT,
          fish: FISH
        },
        {
          id: SecureRandom.uuid,
          name: "Micky Dolenz",
          email: "micky.dolenz@munat.com",
          salt: SALT,
          fish: FISH
        },
        {
          id: SecureRandom.uuid,
          name: "Peter Tork",
          email: "peter.tork@munat.com",
          salt: SALT,
          fish: FISH
        },
        {
          id: SecureRandom.uuid,
          name: "Michael Nesmith",
          email: "michael.nesmith@munat.com",
          salt: SALT,
          fish: FISH
        }
      ]

      TAGS = [
        {
          id: SecureRandom.uuid,
          name: "difficult"
        },
        {
          id: SecureRandom.uuid,
          name: "easy"
        },
        {
          id: SecureRandom.uuid,
          name: "complex"
        },
        {
          id: SecureRandom.uuid,
          name: "simple"
        },
        {
          id: SecureRandom.uuid,
          name: "debugging"
        },
        {
          id: SecureRandom.uuid,
          name: "best practices"
        },
        {
          id: SecureRandom.uuid,
          name: "example"
        },
        {
          id: SecureRandom.uuid,
          name: "tutorial"
        },
        {
          id: SecureRandom.uuid,
          name: "fun"
        },
        {
          id: SecureRandom.uuid,
          name: "painful"
        }
      ]

      CATEGORIES = [
        {
          id: SecureRandom.uuid,
          name: "HTML"
        },
        {
          id: SecureRandom.uuid,
          name: "CSS"
        },
        {
          id: SecureRandom.uuid,
          name: "Ruby"
        },
        {
          id: SecureRandom.uuid,
          name: "CoffeeScript"
        },
        {
          id: SecureRandom.uuid,
          name: "JavaScript"
        },
        {
          id: SecureRandom.uuid,
          name: "Functional Programming"
        },
        {
          id: SecureRandom.uuid,
          name: "Object-Oriented Programming"
        },
        {
          id: SecureRandom.uuid,
          name: "Usability"
        },
        {
          id: SecureRandom.uuid,
          name: "Accessibility"
        }
      ]

      CHALLENGES = [
        {
          id: SecureRandom.uuid,
          name: "HTML Tables",
          categoryId: CATEGORIES[0][:id]
        }
      ]

      INQUIRIES = [
        {
          id: SecureRandom.uuid,
          question: "Who, who wrote the book of love?",
          answers: [
            "Tom Jones",
            "Elvis Presley",
            "Some guy named Steve",
            "JFK, and they killed him for it",
            "Cupid"
          ]
        },
        {
          id: SecureRandom.uuid,
          question: "What is the pain that you want to sustain?",
          answers: [
            "I feel your pain",
            "Did you say pain?",
            "Some guy named Steve",
            "Death... no cake! Cake!",
            "Sustain? Pain? I complain."
          ]
        }
      ]

      TASKS = [
        {
          id: SecureRandom.uuid,
          name: "Do something",
          challengeId: CHALLENGES[0][:id]
        },
        {
          id: SecureRandom.uuid,
          name: "Do something else",
          challengeId: CHALLENGES[0][:id]
        }
      ]

      ATTEMPTS = [
        {
          id: SecureRandom.uuid,
          userId: USERS[0][:id],
          began_at: (Time.now - 1.day) - 4.hours,
          ended_at: (Time.now - 1.day) - 1.hour
        }
      ]

      def require_logged_in
        redirect('/sessions/new') unless is_authenticated?
      end

      def is_authenticated?
        return !!session[:user_id]
      end

      def load_users
        if settings.r.table('users').count() < 1
          settings.r.table('users').insert(USERS).run(@rdb_connection)
        end
      end

      def load_tags
        if settings.r.table('tags').count() < 1
          settings.r.table('tags').insert(TAGS).run(@rdb_connection)
        end
      end

      def load_categories
        if settings.r.table('categories').count() < 1
          settings.r.table('categories').insert(CATEGORIES).run(@rdb_connection)
        end
      end

      def load_challenges
        if settings.r.table('challenges').count() < 1
          settings.r.table('challenges').insert(CHALLENGES).run(@rdb_connection)
        end
      end

      def load_inquiries
        if settings.r.table('inquiries').count() < 1
          settings.r.table('inquiries').insert(INQUIRIES).run(@rdb_connection)
        end
      end

      def load_tasks
        if settings.r.table('tasks').count() < 1
          settings.r.table('tasks').insert(TASKS).run(@rdb_connection)
        end
      end

      def load_attempts
        if settings.r.table('attempts').count() < 1
          settings.r.table('attempts').insert(ATTEMPTS).run(@rdb_connection)
        end
      end

    end
  end
end
