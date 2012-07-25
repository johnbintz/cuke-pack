module CukePack
  class << self
    attr_accessor :screenshot_options
  end

  self.screenshot_options = { :width => 1280, :height => 1024, :prepend_driver_name => true, :directory => "features/screenshots" }
end

def take_screenshot(name, options = {})
  selenium = Capybara.current_session.driver.browser

  if selenium.respond_to?(:manage)
    options = CukePack.screenshot_options.merge(options)

    selenium.manage.window.resize_to(options[:width], options[:height])

    target = options[:directory]
    target = File.join(target, Capybara.current_driver.to_s)
    target = File.join(target, name + ".png")

    FileUtils.mkdir_p File.dirname(target)

    selenium.save_screenshot(target)
  end
end
