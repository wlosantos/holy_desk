# frozen_string_literal: true

Rails.application.configure do
  config.generators do |g|
    g.orm :active_record, migration: true
    g.test_framework :rspec,
      view_specs: false,
      model_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: false,
      request_specs: true,
      fixture: false

    g.helper false
    g.jbuilder false
    g.assets false
    g.template_engine :erb
    g.controller assets: false
  end
end
