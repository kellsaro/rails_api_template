class NewRailsApi
  def main
    rvmrc = `rvm current`
    puts rvmrc

    ruby_version = rvmrc.split('@')[0]
    ruby_gemset = rvmrc.split('@')[1]

    app_name = ARGV[0]

    # set the right ruby and gemset version
    system("rvm use #{ruby_version}@#{ruby_gemset}")

    # creates the rails application
    system("rails new #{app_name} --api --database=postgresql")
    
    # cd to app_name
    system("cd #{app_name}")

    # remove the file .ruby-version
    system("rm #{app_name}/.ruby-version")

    # set the right ruby and gemset version
    system("rvm use #{ruby_version}@#{ruby_gemset}")

    # create .ruby-version and .ruby-gemset files
    system("echo '#{ruby_version}' > #{app_name}/.ruby-version")
    system("echo '#{ruby_gemset}' > #{app_name}/.ruby-gemset")

    # Add gems to Gemfile
    gemfile = File.open("#{app_name}/Gemfile", 'a')
    gemfile.puts "# New gems added -------- "
    gemfile.puts ""
    gemfile.puts gemfile_additions
    gemfile.close

    # Run bundle install
    system("cd #{app_name} && bundle install")

    # Run app template modifications
    system("cd #{app_name} && rails app:template LOCATION=~/path/to/template.rb")

    # Initialize repository
    system("git init")
    system("git add ./")
    system("git commit -m 'Initial commit'")
  end

  private

  def gemfile_additions
    <<-HEREDOC
# Serialization
gem 'fast_jsonapi'
# docs: https://github.com/Netflix/fast_jsonapi

# Enabling Cross-Origin AJAX Requests
gem 'rack-cors'
# docs: https://github.com/cyu/rack-cors

# Protecting from DDoS, brute force attacks, hammering, or
# even monetize with paid usage limits.
# Allows:
# - whitelist: allowing to process normally if certain conditions are true
# - blacklist: sending a denied message instantly for certain requests
# - throttle: checking if the user is within their allowed usage
# - track: tracking this request to be able to log certain information about our requests
gem 'rack-attack'
# docs: https://github.com/kickstarter/rack-attack

# Token authentication
# gem 'devise_token_auth'
# docs: https://github.com/lynndylanhurley/devise_token_auth

group :development, :test do
  # RSpec for specs
  gem 'rspec-rails'
  # docs: https://github.com/rspec/rspec-rails
	
  # Factory Bot for generating random test data
  gem 'factory_bot_rails'
  # docs: https://github.com/thoughtbot/factory_bot_rails

  # Generates fake data.
  gem 'faker'
  # docs: https://github.com/stympy/faker

  # Notifies about n+1 query problem
  gem 'bullet'
  # docs: https://github.com/flyerhzm/bullet
end

group :development do
  # RSpec api documentation
  gem 'rspec_api_documentation'
  # docs: https://github.com/zipmark/rspec_api_documentation

  # Annotates models, fixtures, ...
  gem 'annotate'
  # docs: https://github.com/ctran/annotate_models
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
  # docs: https://www.rubydoc.info/gems/sdoc/1.0.0
end

    HEREDOC
  end
end

NewRailsApi.new().main