#Create a Jekyll container from a Ruby Alpine image

# At a minimum, use Ruby 2.5 or later
# Uncomment the following line if you want to use GitHub Pages (Jekyll 3.9.x):
# FROM ruby:2.7-alpine3.15
# Uncomment the following line if you want to use the latest version of Jekyll:
FROM ruby:3-alpine3.22

# Add Jekyll dependencies to Alpine
RUN apk update
RUN apk add --no-cache build-base gcc cmake git \
    mysql-dev \
    postgresql-dev \
    libffi-dev \
    libxml2-dev \ 
    libxslt-dev \
    gcompat

# Update the Ruby bundler and install Jekyll
RUN gem update bundler && gem install bundler jekyll

# Configure bundler to compile gems from source (important for Alpine)
RUN bundle config set --global force_ruby_platform true
RUN bundle config set --global path '/usr/local/bundle'

# Set working directory
WORKDIR /site

# Copy any existing Gemfile
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the project files
COPY . .

# Expose port 4000
EXPOSE 4000