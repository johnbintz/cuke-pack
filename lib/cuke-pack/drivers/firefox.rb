require 'cuke-pack/drivers'

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

