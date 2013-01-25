# use confirm_js in your step to confirm all alert() and confirm() dialogs
require 'cuke-pack/support/confirm_js'

# write out missing steps automatically
require 'cuke-pack/support/step_writer'

# fail instantly if ENV['FAILFAST'] is set
require 'cuke-pack/support/failfast'

# set the level of flaying on the step definitions
# set it to false to skip flaying
flay_level = 32
require 'cuke-pack/support/flay'

# enable fakefs with @fakefs
# require 'cuke-pack/support/fakefs'

# enable mocha with @mocha
# require 'cuke-pack/support/mocha'

# Timecop support with @timecop
# require 'cuke-pack/support/timecop'

# Browser drivers
# use with ENV['DRIVER']
require 'cuke-pack/drivers'
# require 'cuke-pack/driver/firefox'

