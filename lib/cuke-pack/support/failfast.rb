After do |scenario|
  if ENV['FAILFAST'] && scenario.failed?
    $stderr.puts "Test failed, quitting..."

    Cucumber.wants_to_quit = true
  end
end
