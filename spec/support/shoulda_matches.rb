# frozen_string_literal: true

RSpec.configure do |config|
  # Setting shoulda matcher =================================
  Shoulda::Matchers.configure do |configs|
    configs.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
