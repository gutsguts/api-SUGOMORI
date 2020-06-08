# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Raven.configure do |config|
  config.environments = %w[test production]
end
