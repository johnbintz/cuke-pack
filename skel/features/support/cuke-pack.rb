require 'cuke-pack/support/pause'
require 'cuke-pack/support/pending'
require 'cuke-pack/support/confirm_js'
require 'cuke-pack/support/expect_fields'

Before do
  # if you want pending steps to pause before marking the step as pending,
  # set @pause_ok to true

  @pause_ok = false
end

require 'cuke-pack/support/step_writer'
require 'cuke-pack/support/wait_for'
require 'cuke-pack/support/failfast'

# set the level of flaying on the step definitions
# set it to false to skip flaying
flay_level = 32

require 'cuke-pack/support/flay'

# require 'cuke-pack/support/fakefs'
# require 'cuke-pack/support/mocha'

# Timecop support
# require 'cuke-pack/support/timecop'

# Browser drivers
# use with ENV['DRIVER']
# require 'cuke-pack/driver/firefox'
#
# Simple rails controller/view generator
# probably only any good for me
# require 'cuke-pack/support/rails_generator'

