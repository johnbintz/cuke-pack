# Enable mocha in scenarios tagged @mocha

require 'mocha'

World(Mocha::API)

def ensure_mocha
  return if @_mocha_ensured

  begin
    mocha_verify
  ensure
    mocha_teardown
  end

  @_mocha_ensured = true
end

Before('@mocha') do
  mocha_setup
end

After('@mocha') do
  ensure_mocha
end

