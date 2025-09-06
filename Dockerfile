# Railway-ready Dockerfile for DocuSeal
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential libpq-dev nodejs postgresql-client yarn git

# Set working dir
WORKDIR /app

# Copy Gemfile
COPY Gemfile* ./

# Install Ruby gems
RUN gem install bundler:2.5.10 && bundle install

# Copy rest of app
COPY . .

# Precompile assets (Railway sets RAILS_ENV=production)
RUN bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Run Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
