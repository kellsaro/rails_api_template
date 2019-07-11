# rails_api_template
# Use:
#   rails new MY_EXAMPLE_API_APP --api --database=postgresql --template=/path/to/template.rb
# OR
#   cd /path/to/application
#   rails app:template LOCATION=~/path/to/template.rb

# Adding lines to Gemfile ---------------------
#   Please note that this will NOT install the gems for you 
#   and you will have to run `bundle install` to do that.

# >> gem(*args)
#
#    Adds a gem entry for the supplied gem to the generated application's Gemfile.
#    Example(s):
#
#      gem 'fast_jsonapi'
#
# >> gem_group(*names, &block)
#
#    Wraps gem entries inside a group.
#
#    Example(s):
#      gem_group :development, :test do
#        gem 'rspec-rails'
#        gem 'factory_bot_rails'
#        gem 'faker'
#        gem 'bullet'
#      end
#
# >> add_source(source, options={}, &block)
#
#    Adds the given source to the generated application's Gemfile.
#
#    Example(s):
#
#      add_source "http://gems.github.com"
#
#      add_source "http://gems.github.com/" do
#        gem "rspec-rails"
#      end

#----------------------------------------------

# Adding lines to config/Application.rb -------

# >> environment/application(data=nil, options={}, &block)
#
#    Adds a line inside the Application class for config/application.rb.
#    If options[:env] is specified, the line is appended to the corresponding file in config/environments.
#
#    Example(s):
#
#      environment 'config.action_mailer.default_url_options = {host: "http://yourwebsite.example.com"}', env: 'production'
#
#    A block can be used in place of the data argument.
application do 
  config.middleware.use Rack::Cors do
    allow do
      origins 'localhost:3000' # change to * to enable requests from all origins
      resource '*',
      :headers => :any,
      :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      :methods => [:get, :post, :patch, :put, :delete]
    end
  end
end  
#----------------------------------------------

# Adding files to initializers, lib, vendor directories ---

# >> vendor/lib/file/initializer(filename, data = nil, &block)
#
#    Adds an initializer to the generated application's config/initializers directory.
#
#    Example(s):
#      Let's say you like using Object#not_nil? and Object#not_blank?:
#
#      initializer 'bloatlol.rb', <<-CODE
#        class Object
#          def not_nil?
#           !nil?
#          end
#
#          def not_blank?
#            !blank?
#          end
#        end
#      CODE
#
#    Similarly, lib() creates a file in the lib/ directory and vendor() creates a file in the vendor/ directory.
#
#    There is even file(), which accepts a relative path from Rails.root and creates all the directories/files needed:
#    Example(s):
#
#      file 'app/components/foo.rb', <<-CODE
#        class Foo
#        end
#      CODE
#
#    That'll create the app/components directory and put foo.rb in there.
#----------------------------------------------

# Adding rake files to lib/tasks --------------

# >> rakefile(filename, data = nil, &block)
#
#    Creates a new rake file under lib/tasks with the supplied tasks:
#    Example(s):
#
#      rakefile("bootstrap.rake") do
#        <<-TASK
#          namespace :boot do
#            task :strap do
#              puts "i like boots!"
#            end
#          end
#        TASK
#      end
#
#    The above creates lib/tasks/bootstrap.rake with a boot:strap rake task.
#----------------------------------------------

# Runing generators ---------------------------
# >> generate(what, *args)

#    Runs the supplied rails generator with given arguments.
#    Example(s):
#
#      generate(:scaffold, "person", "name:string", "address:text", "age:number")
#----------------------------------------------

# Runing commands -----------------------------

# >> run(command)
#
#    Executes an arbitrary command. Just like the backticks. 
#    Example(s):
#      Let's say you want to remove the README.rdoc file:
#
#      run "rm README.rdoc"
#----------------------------------------------

# Runing rails commands -----------------------
# >> rails_command(command, options = {})
#
#    Runs the supplied command in the Rails application.
#    Example(s):
#
#      Let's say you want to migrate the database:
#      rails_command "db:migrate"
#
#      You can also run commands with a different Rails environment:
#      rails_command "db:migrate", env: 'production'
#
#      You can also run commands as a super-user:
#      rails_command "log:clear", sudo: true
#
#      You can also run commands that should abort application generation if they fail:
#      rails_command "db:migrate", abort_on_failure: true
#----------------------------------------------

# Adding routes -------------------------------
# >> route(routing_code)
#
#    Adds a routing entry to the config/routes.rb file. 
#    Example(s):
#      In the steps above, we generated a person scaffold and also removed README.rdoc. 
#      Now, to make PeopleController#index the default page for the application:
#
#      route "root to: 'person#index'"
#----------------------------------------------

# Runing commands inside directories ----------
# >> inside(dir)
#
#    Enables you to run a command from the given directory. 
#    Example(s):
#      For example, if you have a copy of edge rails that you wish to symlink from your new apps, you can do this:
#
#      inside('vendor') do
#        run "ln -s ~/commit-rails/rails rails"
#      end
#----------------------------------------------

# Asking questions ----------------------------
# >> ask(question)
#
#    ask() gives you a chance to get some feedback from the user and use it in your templates. 
#    Example(s):
#      Let's say you want your user to name the new shiny library you're adding:
#
#      lib_name = ask("What do you want to call the shiny library ?")
#      lib_name << ".rb" unless lib_name.index(".rb")
# 
#      lib lib_name, <<-CODE
#        class Shiny
#        end
#      CODE
#
#
# >> yes?(question) or no?(question)
#
#    These methods let you ask questions from templates and decide the flow based on the user's answer. 
#    Example(s):
#      Let's say you want to Freeze Rails only if the user wants to:
#
#      rails_command("rails:freeze:gems") if yes?("Freeze rails gems?")
#
#    no?(question) acts just the opposite.
#----------------------------------------------

# Using Git -----------------------------------
# >> git(:command)
#
#    Rails templates let you run any git command:
#    Example(s):
#
#      git :init
#      git add: "."
#      git commit: "-a -m 'Initial commit'"
#----------------------------------------------

# Callbacks to run ----------------------------
# >> after_bundle(&block)
#
#    Registers a callback to be executed after the gems are bundled and binstubs are generated. 
#    Useful for all generated files to version control.
#    Example(s):
#      after_bundle do
#        git :init
#        git add: '.'
#        git commit: "-a -m 'Initial commit'"
#      end
#
# The callbacks gets executed even if --skip-bundle and/or --skip-spring has been passed. 
#
#----------------------------------------------

# Advanced Usage ------------------------------
#
# The application template is evaluated in the context of a Rails::Generators::AppGenerator instance. 
# It uses the apply action provided by Thor. 
# This means you can extend and change the instance to match your needs.

# For example by overwriting the source_paths method to contain the location of your template. 
# Now methods like copy_file will accept relative paths to your template's location.
#   def source_paths
#     [__dir__]
#   end

