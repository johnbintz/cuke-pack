Before do
  if ENV['DRIVER']
    Capybara.current_driver = ENV['DRIVER'].to_sym
  end
end

