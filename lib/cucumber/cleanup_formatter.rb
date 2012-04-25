require 'cucumber/formatter/ansicolor'

module Cucumber
  class CleanupFormatter
    include Cucumber::Formatter::ANSIColor

    def initialize(step_mother, path_or_io, options)
      @step_mother = step_mother
    end

    def after_features(features)
      defs = @step_mother.unmatched_step_definitions

      if !defs.empty?
        $stdout.puts yellow("The following steps are unused:")
        $stdout.puts

        defs.each do |step|
          $stdout.puts yellow(step.file_colon_line)
        end
      end
    end
  end
end

