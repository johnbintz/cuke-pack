MAX_TIMES = 20
WAIT_TIME = 0.1

def wait_for(times = MAX_TIMES)
  1.upto(times) do
    ok = false

    begin
      ok = yield
    rescue Capybara::ElementNotFound, Capybara::Driver::Webkit::Node::ElementNotDisplayedError
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
    rescue Capybara::Driver::Webkit::NodeNotAttachedError, Capybara::ElementNotFound
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

