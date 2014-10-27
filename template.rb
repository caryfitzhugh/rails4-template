# Gems
# ==================================================

# For encrypted password
gem "bcrypt-ruby"
# Useful SASS mixins (http://bourbon.io/)
gem "bourbon"

# For authorization (https://github.com/ryanb/cancan)
gem "cancan"

# HAML templating language (http://haml.info)
gem "haml-rails"
gem "sass-rails"

gem "devise"


# Simple form builder (https://github.com/plataformatec/simple_form)
gem "simple_form", git: "https://github.com/plataformatec/simple_form"

# To generate UUIDs, useful for various things
gem "uuidtools"

gem "activeadmin", github: "activeadmin"

gem_group :development, :test do

  gem "spring"
  gem "pry"
  gem "pry-nav"
end

gem_group :test do

end

gem_group :production do
  # For Rails 4 deployment on Heroku
  # gem "rails_12factor"
  # gem "rails_serve_static_assets"
end


# Setting up foreman to deal with environment variables and services
# https://github.com/ddollar/foreman
# ==================================================
# Use Procfile for foreman
run "echo 'web: bundle exec rails server -p $PORT' >> Procfile"
run "echo PORT=3000 >> .env"
run "echo '.env' >> .gitignore"
# We need this with foreman to see log output immediately
run "echo 'STDOUT.sync = true' >> config/environments/development.rb"



# Initialize CanCan
# ==================================================
run "rails g cancan:ability"

# Clean up Assets
# ==================================================
# Use SASS extension for application.css
run "mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss"

# Remove the require_tree directives from the SASS and JavaScript files.
# It's better design to import or require things manually.
run "sed -i '' /require_tree/d app/assets/javascripts/application.js"
run "sed -i '' /require_tree/d app/assets/stylesheets/application.css.scss"

# Add bourbon to stylesheet file
run "echo >> app/assets/stylesheets/application.css.scss"
run "echo '@import \"bourbon\";' >>  app/assets/stylesheets/application.css.scss"



# Font-awesome: Install from http://fortawesome.github.io/Font-Awesome/
# ==================================================
  run "wget http://fontawesome.io/assets/font-awesome-4.1.0.zip -O font-awesome.zip"
  run "unzip font-awesome.zip && rm font-awesome.zip && mv font-awesome-4.1.0 font-awesome"
  run "cp font-awesome/css/font-awesome.css vendor/assets/stylesheets/"
  run "cp -r font-awesome/fonts public/fonts"
  run "rm -rf font-awesome"
  run "echo '@import \"font-awesome\";' >>  app/assets/stylesheets/application.css.scss"


# Ignore rails doc files, Vim/Emacs swap files, .DS_Store, and more
# ===================================================
run "cat << EOF >> .gitignore
/.bundle
/db/*.sqlite3
/db/*.sqlite3-journal
/log/*.log
/tmp
database.yml
doc/
*.swp
*~
.project
.idea
.secret
.DS_Store
EOF"


# Git: Initialize
# ==================================================
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
