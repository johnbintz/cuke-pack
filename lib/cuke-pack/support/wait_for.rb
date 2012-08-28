MAX_TIMES = 20
WAIT_TIME = 0.1

def _wait_for_exceptions
  exceptions = [ Capybara::ElementNotFound ]
  if defined?(Capybara::Driver::Webkit::Node::ElementNotDisplayedError)
    exceptions << Capybara::Driver::Webkit::Node::ElementNotDisplayedError
  end
  if defined?(Selenium::WebDriver::Error::StaleElementReferenceError)
    exceptions << Selenium::WebDriver::Error::StaleElementReferenceError
  end

  exceptions
end

def _wait_for_not_exceptions
  exceptions = [ Capybara::ElementNotFound ]
  if defined?(Capybara::Driver::Webkit::NodeNotAttachedError)
    exceptions << Capybara::Driver::Webkit::NodeNotAttachedError
  end
  if defined?(Selenium::WebDriver::Error::StaleElementReferenceError)
    exceptions << Selenium::WebDriver::Error::StaleElementReferenceError
  end

  exceptions
end

def wait_for(times = MAX_TIMES)
  1.upto(times) do
    ok = false

    begin
      ok = yield
    rescue *_wait_for_exceptions
      ok = false
    end

    if ok
      return
    else
      sleep WAIT_TIME
    end
  end

  raise StandardError.new("Failed")
end

def wait_for_not(times = MAX_TIMES)
  original_time = Capybara.default_wait_time
  Capybara.default_wait_time = 0

  1.upto(times) do
    ok = false

    begin
      yield
    rescue *_wait_for_not_exceptions
      ok = true
    end

    if ok
      Capybara.default_wait_time = original_time

      return
    else
      sleep WAIT_TIME
    end
  end

  raise StandardError.new('Timed out')
end

